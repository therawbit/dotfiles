percentage=$(upower -d | grep -A 5 -e "headset" | grep "percentage" | awk '{print $2}')
device=$(upower -d | grep -A 5 headset | grep model | awk -F ':' '{print $2}' | awk '{$1=$1};1')
notify-send -t 2000 "$device" "Device Battery: $percentage"
