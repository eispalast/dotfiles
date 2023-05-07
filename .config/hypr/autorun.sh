#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "kdeconnect-indicator"


#nextcloud=$(ls ~/exchange/software | grep Nextcloud | tail -n 1)
#~/exchange/software/$nextcloud &

#~/exchange/software/kmonad/startkmonadkoylight.sh
~/.config/hypr/startkmonad.sh
