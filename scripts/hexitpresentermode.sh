#!/bin/bash

hyprctl keyword monitor eDP-1,2258x1504,auto,1.5
hyprctl keyword monitor HDMI-A-1,preferred,auto,1.5
hyprctl keyword device:wacom-hid-495f-pen:transform 0
hyprctl keyword device:wacom-hid-495f-finger:transform 0

