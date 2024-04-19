#!/bin/bash

hyprctl keyword monitor eDP-1,2256x1504,auto,1.566667
hyprctl keyword monitor HDMI-A-1,preferred,auto,1
hyprctl keyword "device[wacom-hid-495f-pen]:transform" 0
hyprctl keyword "device[wacom-hid-495f-finger]:transform" 0

