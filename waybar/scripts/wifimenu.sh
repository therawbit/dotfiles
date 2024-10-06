#!/usr/bin/env bash

# Global Variables
wifi_list=""
saved_connections=""

# Notify and scan available networks
notify-send "Scanning for Available Networks..."

# Function to toggle Wi-Fi state
toggle_wifi() {
    local current_state=$(nmcli -t -f WIFI g)
    if [[ "$current_state" == "enabled" ]]; then
        nmcli radio wifi off
        notify-send "Wi-Fi Disabled"
    else
        nmcli radio wifi on
        notify-send "Wi-Fi Enabled"
    fi
    exit 0
}

# Function to display available networks
list_wifi_networks() {
    wifi_list=$(nmcli --fields "SECURITY,SSID,Rate" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d" | sed "s/130.*/\[2.4 GHz\]/g" | sed "s/270.*/\[5 GHz\]/g")
}

# Function to connect to a Wi-Fi network
connect_to_wifi() {
    local ssid="$1"
    local password="$2"

    if [[ -n "$password" ]]; then
        nmcli device wifi connect "$ssid" password "$password"
    else
        nmcli device wifi connect "$ssid"
    fi
}

# Function to delete a known connection
delete_connection() {
    local ssid="$1"
    nmcli connection delete id "$ssid" && notify-send "Connection Deleted" "$ssid has been deleted."
}

# Function to handle wrong credentials
handle_wrong_credentials() {
    local ssid="$1"
    notify-send "Connection Failed" "Wrong credentials for $ssid"
    prompt_for_connection "$ssid"
}

# Function to prompt for a connection
prompt_for_connection() {
    local ssid="$1"
    local password=""
    
    # If network is secured, ask for password
    if echo $wifi_list | grep -q "^.*$ssid"; then
        password=$(wofi -d -p "Enter password for $ssid: ")

        # Exit if password prompt is canceled or empty
        if [[ -z "$password" ]]; then
            notify-send "Canceled" "No password entered for $ssid."
            main_menu
            return
        fi

        if connect_to_wifi "$ssid" "$password" | grep -q "successfully"; then
            notify-send "Connection Established" "You are now connected to $ssid."
        else
            handle_wrong_credentials "$ssid"
        fi
    fi
}

# Get current saved connections
get_saved_connections() {
    saved_connections=$(nmcli -g NAME connection)
}

# Function to delete a saved connection with the "Go Back" option
delete_saved_connection() {
    local go_back_option="Go Back"

    # Show saved connections along with the "Go Back" option
    local connection_to_delete=$(echo -e "$go_back_option\n$saved_connections" | wofi -d -p "Select connection to delete: ")
    
    if [[ "$connection_to_delete" == "$go_back_option" || -z "$connection_to_delete" ]]; then
        main_menu
    else
        delete_connection "$connection_to_delete"
        main_menu
    fi
}

# Main Menu
main_menu() {
    local toggle_option="Toggle Wi-Fi"
    local delete_option="Delete Known Connection"

    # Display options with wofi
    local chosen_network=$(echo -e "$toggle_option\n$delete_option\n$wifi_list" | wofi -d -p "Wi-Fi SSID: ")

    if [[ -z "$chosen_network" ]]; then
        exit 0
    elif [[ "$chosen_network" == "$toggle_option" ]]; then
        toggle_wifi
    elif [[ "$chosen_network" == "$delete_option" ]]; then
        delete_saved_connection
    else
        # Extract SSID and remove any trailing spaces
        local ssid=$(echo "${chosen_network:3}" | cut -d '[' -f 1 | xargs)

        # Check if the network is saved
        if echo "$saved_connections" | grep -qw "$ssid"; then
            # Try to connect using saved credentials
            if nmcli connection up id "$ssid" | grep -q "successfully"; then
                notify-send "Connection Established" "Connected to $ssid."
            else
                handle_wrong_credentials "$ssid"
            fi
        else
            prompt_for_connection "$ssid"
        fi
    fi
}

# Main Flow
list_wifi_networks   # Fetch the available Wi-Fi networks globally
get_saved_connections  # Fetch saved connections globally
main_menu             # Show the main menu

