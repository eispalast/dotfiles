#!/bin/bash
# Set Display resolution and mirror screen
xrandr --output eDP-1 --mode 1920x1080
xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1

touchscreen=$(xinput list | grep "Pen stylus" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
touchscreen_area=$(xinput list-props $touchscreen | grep "Coordinate Transformation Matrix (" | cut -d ")" -f 1 | tr -d -c 0-9)

eraser=$(xinput list | grep "Pen eraser" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
finger=$(xinput list | grep "Finger" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
xinput set-prop $touchscreen $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.18, -0.09, 0.0, 0.0, 1.0

xinput set-prop $eraser $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.18, -0.09, 0.0, 0.0, 1.0
xinput set-prop $finger $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.18, -0.09, 0.0, 0.0, 1.0

