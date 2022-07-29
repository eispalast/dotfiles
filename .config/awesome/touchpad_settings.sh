# reverse scroll
touchpad=$(xinput list | grep "Touchpad" | sed 's/.*id=//' | cut -d "[" -f 1 | tr -d -c 0-9)
reverse_scroll=$(xinput list-props $touchpad | grep "Natural Scrolling Enabled (" | cut -d ")" -f 1 | tr -d -c 0-9)
tapping=$(xinput list-props $touchpad | grep "Tapping Enabled (" | cut -d ")" -f 1 | tr -d -c 0-9)
middle_button=$(xinput list-props $touchpad | grep "Middle Emulation  Enabled (" | cut -d ")" -f 1 | tr -d -c 0-9)

xinput set-prop $touchpad $reverse_scroll 1
xinput set-prop $touchpad $tapping 1
xinput set-prop $middle_button $tapping 1
