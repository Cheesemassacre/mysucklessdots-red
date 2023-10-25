#! /usr/bin/bash
ls -1 /home/marin/Pictures/Wallpapers | dmenu -l 10 -p "Wallpapers:" | xargs -I {} -n 1 nitrogen --set-auto Pictures/Wallpapers/{}