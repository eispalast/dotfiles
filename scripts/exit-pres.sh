#!/bin/bash
# Set Display resolution and mirror screen
xrandr --output eDP-1 --mode 2256x1504 --set 'scaling mode'  'None' --dpi 144 --rotate normal
xrandr --output HDMI-1 --mode 1920x1080 --left-of eDP-1 --rotate normal

touchscreen=$(xinput list | grep "Pen Pen" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
eraser=$(xinput list | grep "Pen Eraser" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
finger=$(xinput list | grep "Finger" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
touchscreen_area=$(xinput list-props $touchscreen | grep "Coordinate Transformation Matrix (" | cut -d ")" -f 1 | tr -d -c 0-9)

xinput set-prop $touchscreen $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.00, 0.0, 0.0, 0.0, 1.0
xinput set-prop $eraser $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.00, 0.0, 0.0, 0.0, 1.0
xinput set-prop $finger $touchscreen_area 1.0, 0.0, 0.0, 0.0, 1.00, 0.0, 0.0, 0.0, 1.0


