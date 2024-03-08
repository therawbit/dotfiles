
#! /bin/bash
chosen=$(printf "Bluetooth Device Battery\nNepali Date" | rofi -dmenu -i -p "Utilities" -font "Hack 15" )

case "$chosen" in
	"Bluetooth Device Battery") ~/.config/scripts/bluetooth-battery.sh;;
	"Nepali Date") ~/.config/scripts/nepalidate.sh;;
	*) exit 1 ;;
esac
