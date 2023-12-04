#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/config.json $HOME/.config/waybar/style.css"

trap "killall waybar" EXIT

while true; do
    waybar -c ~/.config/waybar/config.json&
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done