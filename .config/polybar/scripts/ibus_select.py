#!/usr/bin/python3

import subprocess
from collections import namedtuple


IbusEngine = namedtuple('IbusEngine', ('code', 'name'))


# ----------  BEGINNING OF SCRIPT ----------

# Get available engines
list_engines_command = ['ibus', 'list-engine']
list_engines_result = subprocess.run(list_engines_command, stdout=subprocess.PIPE)
list_engines_output = list_engines_result.stdout.decode('utf-8')
engines = [IbusEngine(*[l.strip() for l in line.split(' - ')])
           for line in list_engines_output.split('\n') if line and not line.startswith('language:')]

# Use rofi to ask the user which ibus engine to use
ROFI_IBUS_PROMPT = "layout: "
rofi_command = ['rofi', '-dmenu', '-i', '-format', 'i', '-p', ROFI_IBUS_PROMPT]

input_str = '\n'.join([engine.name for engine in engines])

rofi_result = subprocess.run(rofi_command, input=input_str, stdout=subprocess.PIPE, encoding='utf-8')

if rofi_result.returncode != 0:
    exit(rofi_result.returncode)

rofi_output = rofi_result.stdout.split(":")
index = int(rofi_output[0])

if index < 0:
    exit(-1)

change_layout_command = ['ibus', 'engine', engines[index].code]
change_layout_result = subprocess.run(change_layout_command)

if change_layout_result.returncode != 0:
    subprocess.run(['notify-send', '"{}"'.format(change_layout_result.stdout)])

exit(change_layout_result.returncode)
