#!/bin/bash

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

let brightness+=500
echo $brightness > /sys/class/backlight/intel_backlight/brightness