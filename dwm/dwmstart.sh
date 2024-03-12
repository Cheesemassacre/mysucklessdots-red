#!/bin/sh
picom -b --config /home/marin/.config/picom/picom2.conf &
feh --bg-scale Pictures/wallhaven-qzveyd.jpg &
sxhkd -c /home/marin/.config/sxhkd/sxhkdrc2 &
exec /usr/libexec/xfce-polkit &
flameshot &
greenclip daemon &

while true; do
	xsetroot -name "$(date '+ %a %d/%m %H:%M ')"
	sleep 2
done
