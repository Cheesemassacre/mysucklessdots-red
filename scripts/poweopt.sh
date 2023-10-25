#! /usr/bin/bash
echo -e "poweroff\nreboot\nsuspend" | dmenu -l 3 -p "Power Options:" | xargs systemctl | exit