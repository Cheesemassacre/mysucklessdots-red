#! /usr/bin/bash
if [ $(echo -e 'Enabled \nDisabled' | dmenu -l 2 -p "Sleep state:") = 'Disabled' ]; then
killall xfce4-power-manager | notify-send "Sleep disabled" -t 2000
else exec "xfce4-power-manager" | notify-send "Sleep enabled" -t 2000
fi
