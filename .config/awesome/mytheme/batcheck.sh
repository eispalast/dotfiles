#!/bin/bash
acpi | sed 's/Battery 0: //g' | sed 's/Discharging,/Bat:/g' | sed 's/:[0-9][0-9] remaining/ left /g'
