#!/bin/bash
#
current=$(powerprofilesctl get)
selected=$(printf "Performance\nBalanced\nPower Saver" | wofi -d -p "$current" -i)

case $selected in
"Performance")
  powerprofilesctl set performance;
  ;;
"Balanced")
  powerprofilesctl set balanced;
  ;;
"Power Saver")
  powerprofilesctl set power-saver;
  ;;
esac
