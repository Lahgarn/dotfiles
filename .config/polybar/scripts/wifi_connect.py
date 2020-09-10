#!/usr/bin/python3

import subprocess
from collections import namedtuple


APListItem = namedtuple('APListItem', ('active', 'ssid', 'mode', 'channel', 'rate', 'signal', 'bars', 'security'))
ConListItem = namedtuple('ConListItem', ('name', 'uuid', 'type', 'device'))

# ----------  ACTIONS ----------
Action = namedtuple('Action', ('action', 'item'))

# Action types
ACT_CONNECT_WLAN = 'connect_wlan'
ACT_DISCONNECT_WLAN = 'disconnect_wlan'
ACT_CONNECT_VPN = 'connect_vpn'
ACT_DISCONNECT_VPN = 'disconnect_vpn'


WLAN_ITEM_FORMAT = '{bars} ({signal:>3}%) -- {ssid} ({rate})'
VPN_ITEM_FORMAT = 'VPN -- {name}'


def format_action(action):
    item = action.item
    if action.action == ACT_CONNECT_VPN:
        return '[con] ' + VPN_ITEM_FORMAT.format(name=item.name)
    if action.action == ACT_CONNECT_WLAN:
        return '[con] ' + WLAN_ITEM_FORMAT.format(bars=item.bars, signal=item.signal, ssid=item.ssid, rate=item.rate)
    if action.action == ACT_DISCONNECT_VPN:
        return '[dis] ' + VPN_ITEM_FORMAT.format(name=item.name)
    if action.action == ACT_DISCONNECT_WLAN:
        return '[dis] ' + WLAN_ITEM_FORMAT.format(bars=item.bars, signal=item.signal, ssid=item.ssid, rate=item.rate)

def get_command(action):
    item = action.item
    if action.action == ACT_CONNECT_VPN:
        return ['nmcli', 'connection', 'up', item.name], None
    if action.action == ACT_CONNECT_WLAN:
        return ['nmcli', 'connection', 'up', item.ssid], ['nmcli', 'device', 'wifi', 'connect', item.ssid]
    if action.action == ACT_DISCONNECT_VPN:
        return ['nmcli', 'connection', 'down', item.name], None
    if action.action == ACT_DISCONNECT_WLAN:
        return ['nmcli', 'connection', 'down', item.ssid], None

# ----------  BEGINNING OF SCRIPT ----------

# Get available wifi APs with nmcli
list_aps_command = ['nmcli', '-t', 'device', 'wifi', 'list']
list_aps_result = subprocess.run(list_aps_command, stdout=subprocess.PIPE)
list_aps_output = list_aps_result.stdout.decode('utf-8')
try:
    nm_items = [APListItem(*line.split(':')) for line in list_aps_output.split('\n') if line]
except Exception:
    print([line.split(':') for line in list_aps_output.split('\n') if line])
    raise

# Get VPN status
list_con_command = ['nmcli', '-t', 'connection', 'show']
list_con_result = subprocess.run(list_con_command, stdout=subprocess.PIPE)
list_con_output = list_con_result.stdout.decode('utf-8')
con_items = [ConListItem(*line.split(':')) for line in list_con_output.split('\n') if line]

available_vpns = [item for item in con_items if item.type == 'vpn' and item.device.strip() == '']
active_vpns = [item for item in con_items if item.type == 'vpn' and item.device.strip() != '']

# Make a unique list of ssids
ssids = set()
unique_wlans = []
active_wlans = []

for item in nm_items:
    if item.active == '*':
        active_wlans.append(item)
    elif item.ssid not in ssids and item.ssid != '':
        unique_wlans.append(item)
    ssids.add(item.ssid)

# Build all available actions
actions = []
actions.extend(Action(ACT_DISCONNECT_WLAN, item) for item in active_wlans)
actions.extend(Action(ACT_DISCONNECT_VPN, item) for item in active_vpns)
actions.extend(Action(ACT_CONNECT_WLAN, item) for item in unique_wlans)
actions.extend(Action(ACT_CONNECT_VPN, item) for item in available_vpns)

actions_format = [format_action(action) for action in actions]

# Use rofi to ask the user which AP to connect to
ROFI_WIFI_PROMPT = "wifi: "
rofi_command = ['rofi', '-dmenu', '-i', '-format', 'i:s', '-p', ROFI_WIFI_PROMPT]
active_len = len(active_wlans) + len(active_vpns)
if active_len:
    rofi_command.extend(['-a', '0-{}'.format(active_len - 1)])

input_str = '\n'.join(actions_format)

rofi_result = subprocess.run(rofi_command, input=input_str, stdout=subprocess.PIPE, encoding='utf-8')

if rofi_result.returncode != 0:
    exit(rofi_result.returncode)

rofi_output = rofi_result.stdout.split(":")
index = int(rofi_output[0])

fallback_code = None

if index < 0:
    exit(-1)

command, fallback_command = get_command(actions[index])

connect_result = subprocess.run(command)

if connect_result.returncode == 10:
    connect_result = subprocess.run(fallback_command)

exit(connect_result.returncode)

