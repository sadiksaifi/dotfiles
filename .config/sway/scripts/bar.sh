#!/bin/sh

# Function to get network status
get_network_status() {
    wlan_status=$(cat /sys/class/net/wlan0/operstate 2>/dev/null || cat /sys/class/net/wlp29s0/operstate 2>/dev/null || cat /sys/class/net/wlp0s20f3/operstate 2>/dev/null)
    lan_status=$(cat /sys/class/net/enp27s0/operstate 2>/dev/null)

    if [ "$wlan_status" = "up" ] || [ "$lan_status" = "up" ]; then
        echo ""  # Connected icon
    else
        echo "󱧝"  # Disconnected icon
    fi
}

# Function to get formatted date
get_formatted_date() {
    date "+%a %b %d, %H:%M"
}

# Function to get audio level
get_audio_level() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ printf "%.0f\n", $2 * 100 }'
}

# Function to get battery level
get_battery_level() {
    battery_file="/sys/class/power_supply/BAT1/capacity"
    if [ -s "$battery_file" ]; then
        echo " |  $(cat "$battery_file")%"  # Battery icon
    fi
}

# Main script
network_status=$(get_network_status)
audio_level=$(get_audio_level)
date_formatted=$(get_formatted_date)
battery_info=$(get_battery_level)

echo "$network_status | 󰕾 $audio_level%$battery_info |  $date_formatted"

