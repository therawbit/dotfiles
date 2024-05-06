#!/usr/bin/env bash

# Notification
notify-send "Scanning for Available networks..."

# Get a list of available wifi connections and format it
wifi_list=$(nmcli --fields "SECURITY,SSID,Rate" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d" | sed "s/130.*/\[2.4 GHz\]/g" | sed "s/270.*/\[5 GHz\]/g")

# Check Wi-Fi state
connected=$(nmcli -t -f WIFI g)
if [[ "$connected" == "enabled" ]]; then
    toggle="Disable Wi-Fi"
elif [[ "$connected" == "disabled" ]]; then
    toggle="Enable Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | wofi -d -p "Wi-Fi SSID: ")
# Get name of connection
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [[ "$chosen_network" = "" ]]; then
    exit
elif [[ "$chosen_network" = "Enable Wi-Fi" ]]; then
    nmcli radio wifi on
    notify-send "Wi-Fi Enabled"
elif [[ "$chosen_network" = "Disable Wi-Fi" ]]; then
    nmcli radio wifi off
    notify-send "Wi-Fi Disabled"
else
    # Check if the network is saved
    saved_connections=$(nmcli -g NAME connection)
    if grep -qw "$chosen_id" <<< "$saved_connections"; then
        success_message="Connection Established to $chosen_id."
        nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
    else
    	ssid=$(echo $chosen_id | cut -d '[' -f 1 | cut -d ' ' -f 1)
    	echo "ssid: $ssid"
        # Prompt for password if needed
        if [[ "$chosen_network" =~ "" ]]; then
            wifi_password=$(wofi -d -p "Password: ")
        fi
        nmcli device wifi connect "$ssid" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "You are now connected to $chosen_id."
    fi
fi
