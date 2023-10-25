#! /usr/bin/bash
ps aux | dmenu -l 30 -p "Kill process:" | xargs kill | exit