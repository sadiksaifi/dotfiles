[[ -f ~/.zshrc ]] && . ~/.zshrc 

# Starting WM
if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep Hyprland || exec Hyprland
fi

#Startx for dwm tty1
# if [[ "$(tty)" = "/dev/tty1" ]]; then
#   startx "/home/sdk/.config/X11/xinitrc"
# fi
