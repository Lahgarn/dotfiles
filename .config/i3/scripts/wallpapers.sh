#!/bin/bash

script_name=${BASH_SOURCE[0]}
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi
done

# source /home/marc/venv/marc/bin/activate

while true
do
    # python /home/marc/Pictures/Pixel/render.py
    # feh --bg-center /home/marc/Pictures/Pixel/rendered.bmp
    feh --randomize --bg-fill ~/Pictures/Island/extra/*.jpg
    sleep 5m
done
