#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "xrandr --output eDP-1 --mode 2256x1504 --set 'scaling mode' 'None' --pos 0x0 --rotate normal --rate 60 --dpi 144"
run "kdeconnect-indicator"
run "nextcloud"
picom --config ~/.config/picom/picom.conf -b
#run "kdeconnect-indicator"

# nitrogen --restore

#compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible &

#~/exchange/software/kmonad/startkmonadkoylight.sh
~/.config/awesome/startkmonad.sh
