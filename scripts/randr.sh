#! /bin/bash

numberOfDevices=$(xrandr | grep connected -w | wc -l)
secPolybarInstance=$(ps -ax | grep "\spolybar -r sec" | awk '{print $1}' | ps -ax | grep "\spolybar -r sec" | awk '{print $1}')
if [ $numberOfDevices -eq 2 ]
then
	xrandr --output HDMI-1 --right-of eDP-1 --auto
	if [ "$secPolybarInstance" = "" ]
	then	
		polybar -r sec 2>/dev/null | tee -a /tmp/polybar1.log & disown
	fi	
else 
	kill $secPolybarInstance
	xrandr --output HDMI-1 --off
fi	
