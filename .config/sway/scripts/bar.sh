#!/bin/sh

date_formatted=$(date "+%a %b %d, %H:%M")
battery_level=$(cat /sys/class/power_supply/BAT1/capacity)
network=$(cat /sys/class/net/wlan0/operstate)

network_status=""
if [ "$network" = "up" ]; then
    network_status="󰖩 "
else
    network_status="󰖪 "
fi

echo "$network_status |   $battery_level% |   $date_formatted"
