#! /usr/bin/bash
ps aux | awk '{print $3,$4,$10,$11}' | tr -d % | dmenu -l 30 -p "Kill process:" | xargs killall | exit


