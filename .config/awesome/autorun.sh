#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# run "compton"
run "xrandr --output eDP-1 --mode 2256x1504 --set 'scaling mode' 'None' --pos 0x0 --rotate normal --rate 60 --dpi 144"
run "keepassxc"
picom --config ~/.config/picom/picom.conf -b
#run "kdeconnect-indicator"

# nitrogen --restore

#compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible &
nextcloud=$(ls ~/software | grep Nextcloud | tail -n 1)
~/software/$nextcloud &

~/.config/awesome/startkmonad.sh
