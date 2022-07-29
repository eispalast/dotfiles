#!/bin/bash
DEVICE=Headphone
if [ $(amixer get Headphone | grep "\[on\]" 2>/dev/null | wc -l) -eq 0 ] 
    then
    DEVICE=Speaker
fi

amixer set $DEVICE "2%+" -M 1>/dev/null