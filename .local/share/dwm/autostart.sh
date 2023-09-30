#!/bin/sh

# Essentials
setxkbmap -option caps:escape &
xset r rate 240 50 &
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom &
dunst &
sxhkd &
xwallpaper --zoom /home/sdk/.local/share/sdk/wall.jpg &
/home/sdk/.local/bin/bar-time &
