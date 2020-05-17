#!/bin/bash
INTERNAL_OUTPUT="eDP-1"

EXTERNAL_OUTPUT_1="DP-1"
EXTERNAL_OUTPUT_2="DP-2"

## MONITOR CONFIGURATION

#    .----------. .------------. .------------.
#    |          | |            | |            |
#    |  eDP-1   | |    DP-2    | |    DP-1    |
#    |          | |            | |            |
#    '----------' '------------' '------------'
#    /_/_/__\_\_\       I               I
#   /_/_/____\_\_\     _I_             _I_


# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"
# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
    monitor_mode="INTERNAL"
    xrandr --output $INTERNAL_OUTPUT --auto
    xrandr --output $EXTERNAL_OUTPUT_1 --off
    xrandr --output $EXTERNAL_OUTPUT_2 --off
    notify-send 'External display OFF'
# elif [ $monitor_mode = "EXTERNAL" ]; then
#         monitor_mode="INTERNAL"
#         xrandr --output $INTERNAL_OUTPUT --auto
#         xrandr --output $EXTERNAL_OUTPUT_1 --off
#         xrandr --output $EXTERNAL_OUTPUT_2 --off
# elif [ $monitor_mode = "INTERNAL" ]; then
#         monitor_mode="CLONES"
#         xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
else
    monitor_mode="all"
    xrandr --output $INTERNAL_OUTPUT --auto
    xrandr --output $EXTERNAL_OUTPUT_1 --auto --right-of $INTERNAL_OUTPUT
    xrandr --output $EXTERNAL_OUTPUT_2 --auto --right-of $EXTERNAL_OUTPUT_1
    ~/.config/polybar/launch.sh
    notify-send 'External display ON'
fi

echo "${monitor_mode}" > /tmp/monitor_mode.dat
