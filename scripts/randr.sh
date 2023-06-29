#!/bin/bash

chosen=$(printf "󱂫  Join Screen\n  Mirror Screen\n󰍹  Off" | rofi -dmenu -i -p "Multi Screen" -font "Hack 15" )
secPolybarInstance=$(ps -ax | grep "\spolybar -r sec" | awk '{print $1}' | ps -ax | grep "\spolybar -r sec" | awk '{print $1}')

if [ "$chosen" = "󱂫  Join Screen" ]
then
    xrandr --output HDMI-1 --right-of eDP-1 --auto
	if [ "$secPolybarInstance" = "" ]
	then	
		polybar -r sec 2>/dev/null | tee -a /tmp/polybar1.log & disown
	fi
elif [ "$chosen" = "  Mirror Screen" ]
then
	kill $secPolybarInstance
    xrandr --output HDMI-1 --same-as eDP-1 --auto
elif [ "$chosen" = "󰍹  Off" ]
then
    kill $secPolybarInstance
	xrandr --output HDMI-1 --off
fi    