#!/bin/bash

hyprctl keyword monitor eDP-1,1920x1080,auto,1
hyprctl keyword monitor HDMI-A-1,1920x1080,auto,1
sleep 3 
hyprctl keyword monitor HDMI-A-1,1920x1080,auto,1,mirror,eDP-1
# hyprctl keyword device {name = wacom-hid-495f-finger transform=4}
# hyprctl keyword device {name = wacom-hid-495f-pen transform=4}
hyprctl keyword "device[wacom-hid-495f-pen]:transform" 4
hyprctl keyword "device[wacom-hid-495f-finger]:transform" 4
