# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light sunlei/zsh-ssh

# add snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker-compose

# load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# keybindings emacs mode
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# aliases
alias ls='ls --color'
alias ipkg='sudo pacman -S'
alias rmpkg='sudo pacman -R'
alias auri='yay -S'
alias resetsudo='faillock --reset'
alias resetkde='XDG_MENU_PREFIX=arch- kbuildsycoca6'
alias code='code --password-store=gnome-libsecret'
alias jstrm='mpv --no-config --hwdec=nvdec --player-operation-mode=pseudo-gui'
alias inc-bright-dp1='ddcutil --display=1 setvcp 10 + 5'
alias dec-bright-dp1='ddcutil --display=1 setvcp 10 - 5'
alias inc-bright-dp2='ddcutil --display=2 setvcp 10 + 5'
alias dec-bright-dp2='ddcutil --display=2 setvcp 10 - 5'
alias totp='oathtool --totp --base32'
alias neofetch='fastfetch'
alias start-phone-webcam='adb wait-for-usb-device && adb forward tcp:8080 tcp:8080 && ffmpeg -i http://127.0.0.1:8080/video -vf format=yuv420p -f v4l2 /dev/video69'

# bluelight filter
alias blfon25='hyprshade on blfilter25'
alias blfon50='hyprshade on blfilter50'
alias blfon='hyprshade on blfilter100'
alias blfoff='hyprshade off'

# kubernetes kubectl
alias k='kubectl'

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -a  --color=always' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

# Eza (ls replacement)
alias tree='eza --tree'

# Bat (better cat)
alias cat='bat'

# bun stuff
alias npx='bunx'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias ssh='kitten ssh'

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# hyprdots stuff
# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

# Add to PATH
path+=('/home/liangyiu/.local/bin')
export PATH

export TERMINAL=/usr/bin/kitty

# Turso
export PATH="$PATH:/home/liangyiu/.turso"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/liangyiu/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
