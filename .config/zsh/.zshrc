#	 _______| |__  _ __ ___
#	|_  / __| '_ \| '__/ __|
#	 / /\__ \ | | | | | (__
#	/___|___/_| |_|_|  \___|

# Zap plugin manager.
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "esc/conda-zsh-completion"
plug "zap-zsh/supercharge"
plug "sadikeey/zsh-ex"
# plug "sadikeey/sdk-prompt"

#General Key-bindings
bindkey -s '^o' 'lf^M'
bindkey -s '^e' 'edit-configs^M'
bindkey -s '^g' 'lazygit^M'
bindkey -s '^f' 'tmux-sessionizer\n'

#Aliases
alias cp='cp -ivr'
alias mv='mv -iv'
alias rm='rm -vI'
alias ls='exa -lh --color=auto --group-directories-first --icons'
alias ll='exa -lah --color=auto --group-directories-first --icons'
alias mkdir='mkdir -pv'
alias vim='nvim'
alias vr='sudo virsh net-start default'
alias grep='grep --color=auto'
alias myclock='tty-clock -c -s -t -B -C 7'
alias mirror='sudo reflector --fastest 10 --country India --sort rate --save /etc/pacman.d/mirrorlist'
alias pac='sudo pacman'
alias lvs='live-server'
alias wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"
alias smi='sudo make clean install'
alias emacs='emacsclient -nw -c -a "emacs"'
alias phone="mkdir /tmp/cell && simple-mtpfs --device 1 /tmp/cell && cd /tmp/cell"
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias pnx='pnpm dlx'
alias gitlog='git log --all --decorate --graph'

# Prompt
eval "$(starship init zsh)"
