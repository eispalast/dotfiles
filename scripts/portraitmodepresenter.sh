#!/bin/bash
# Set Display resolution and mirror screen
xrandr --output eDP-1 --mode 1920x1080 --rotate right
xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1 --rotate right

touchscreen=$(xinput list | grep "Pen Pen" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
touchscreen_area=$(xinput list-props $touchscreen | grep "Coordinate Transformation Matrix (" | cut -d ")" -f 1 | tr -d -c 0-9)

eraser=$(xinput list | grep "Pen Eraser" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
finger=$(xinput list | grep "Finger" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
xinput set-prop $touchscreen --type=float $touchscreen_area 0.0, 1.18, -0.09, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0

xinput set-prop $eraser --type=float $touchscreen_area 0.0, 1.18, -0.09, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0
xinput set-prop $finger --type=float $touchscreen_area 0.0, 1.18, -0.09, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0

