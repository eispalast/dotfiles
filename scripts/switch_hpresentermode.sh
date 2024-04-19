#!/bin/bash


if [ x"$@" = x"start presentermode" ]
then 
    ~/scripts/hpresentermode.sh > /dev/null &
    exit 0
fi
if [ x"$@" = x"exit presentermode" ]
then 
    ~/scripts/hexitpresentermode.sh > /dev/null
    exit 0
fi

echo "start presentermode"
echo "exit presentermode"
