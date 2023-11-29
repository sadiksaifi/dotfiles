[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc 
[[ -f ~/.zshenv ]] && . ~/.zshenv 

# Starting WM
if [[ "$(tty)" = "/dev/tty1" ]]; then
  # pgrep Hyprland || exec Hyprland
  pgrep sway || exec sway
fi

#Startx for dwm tty1
# if [[ "$(tty)" = "/dev/tty1" ]]; then
#   startx "/home/sdk/.config/X11/xinitrc"
# fi
