#!/bin/bash
DEVICE=$1
UPDOWN=$2

amixer -c 0 set $DEVICE "2%${UPDOWN}" -M 1>/dev/null
