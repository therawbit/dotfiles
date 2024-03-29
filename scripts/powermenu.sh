#! /bin/bash
chosen=$(printf "  Power Off\n  Restart\n Log Out" | rofi -dmenu -i -font "Hack 15" )

case "$chosen" in
	"  Power Off") poweroff ;;
	"  Restart") reboot ;;
	" Log Out") hyprctl dispatch exit ;;
	*) exit 1 ;;
esac