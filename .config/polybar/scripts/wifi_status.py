#!/usr/bin/python3

import time
import subprocess
from collections import namedtuple


APListItem = namedtuple('APListItem', ('active', 'ssid', 'mode', 'channel', 'rate', 'signal', 'bars', 'security'))
ConListItem = namedtuple('ConListItem', ('name', 'uuid', 'type', 'device'))


if True:
    # Get available wifi APs with nmcli
    list_aps_command = ['nmcli', '-t', 'device', 'wifi', 'list']
    list_aps_result = subprocess.run(list_aps_command, stdout=subprocess.PIPE)
    list_aps_output = list_aps_result.stdout.decode('utf-8')
    nm_items = [APListItem(*line.split(':')) for line in list_aps_output.split('\n') if line]

    active_items = [item for item in nm_items if item.active == '*']


    # Get VPN status
    list_con_command = ['nmcli', '-t', 'connection', 'show']
    list_con_result = subprocess.run(list_con_command, stdout=subprocess.PIPE)
    list_con_output = list_con_result.stdout.decode('utf-8')
    con_items = [ConListItem(*line.split(':')) for line in list_con_output.split('\n') if line]

    active_vpn = [item for item in con_items if item.type == 'vpn' and item.device.strip() != '']

    if active_items:
        active_item = active_items[0]
        wifi_status = '{ssid} [{signal}%]'.format(signal=active_item.signal, ssid=active_item.ssid)
    else:
        wifi_status = 'disconnected'

    vps_status = '[VPN]' if active_vpn else ''

    print(''.join([wifi_status, vps_status]).strip())
    # time.sleep(3)
