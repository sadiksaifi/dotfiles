#!/bin/sh
killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar -c $HOME/.config/hypr/waybar/config -s $HOME/.config/hypr/waybar/style.css
