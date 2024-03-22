
#! /bin/bash
chosen=$(printf "Bluetooth Device Battery\nNepali Date" | wofi -d  -i -p "Utilities" )

case "$chosen" in
	"Bluetooth Device Battery") ~/.config/scripts/bluetooth-battery.sh;;
	"Nepali Date") ~/.config/scripts/nepalidate.sh;;
	*) exit 1 ;;
esac
