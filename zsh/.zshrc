# Local ZSH stuff
if [[ -e "$HOME/.zshlocalrc" ]]; then
   . "$HOME/.zshlocalrc"
fi

# Set up a place to dump all my ZSH stuff
[[ -d "$HOME/.zsh" ]] || mkdir -p "$HOME/.zsh"
[[ -d "$HOME/.zsh/cache" ]] || mkdir -p "$HOME/.zsh/cache"
[[ -d "$HOME/.zsh/antigen" ]] || git clone https://github.com/zsh-users/antigen.git "$HOME/.zsh/antigen"
[[ -e "$HOME/.zsh/antigen.zsh" ]] || ln -s "$HOME/.zsh/antigen/antigen.zsh" "$HOME/.zsh/antigen.zsh"

EDITOR=vim
PAGER=less

HISTFILE="$HOME/.zsh/histfile"
HISTSIZE=16384
SAVEHIST=16384
DIRSTACKSIZE=20

COMPDUMPFILE="$HOME/.zsh/zcompdump"

setopt auto_cd # cd just by using dirname
setopt auto_pushd # auto pushd, it's like browser history.
setopt pushd_ignore_dups # ignore dups in pushd
setopt pushd_silent # stfu
setopt pushd_minus # - easier to type than +

setopt hist_ignore_dups # ignore dups in history so we dont end up scrolling for years
setopt hist_verify # !command verification, ensures no accidents
setopt share_history # shares history (reads immedaitely, writes immediately)

setopt prompt_subst # allows prompt to work

setopt correct # like the arch setup terminal

setopt complete_in_word # put cursor in middle of word, press tab to fix word.
setopt always_to_end # move cursor to the end afterwards

setopt glob_complete # tabbing a * opens menu instead of inserting everything

unsetopt flow_control # annoying

if [[ -d "/usr/local/share/zsh-completions" ]]; then
   # Arch and stuff installs this in site-functions, which is cool,
   # but OSX requires manually adding this to the fpath
   fpath=("/usr/local/share/zsh-completions" $fpath)
fi

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Completion Configuration
zmodload -i zsh/complist

autoload -Uz compinit
compinit -d "$COMPDUMPFILE"

# Completion Quick Reference
# :completion:<function>:<completer>:<command>:<argument>:<tag>
#
# :completion:* will set that option for all tags

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s' # page matches
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache"

zstyle ':completion:*' verbose yes
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{white}%B%d%b%f'

# Stolen from oh-my-zsh - ignore uninteresting users
zstyle ':completion:*:users' ignored-patterns adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna clamav colord daemon dbus distcache dnsmasq dovecot fax ftp games gdm gkrellmd gopher hacluster haldaemon halt hsqldb http ident junkbust kdm ldap lp mail mailman mailnull man messagebus mldonkey murmur mysql nagios named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync 'systemd-*' tftp usbmux uucp uuidd vcsa wwwrun xfs '_*'
zstyle ':completion:*:_ignored:*:*:*' single-ignored show

# SCP/SSH completion improvements - usually there is way too much info!
zstyle ':completion:*:*:scp:*' tag-order files 'users hosts:-host hosts:-domain:domain hosts:-ipaddr:ip\ addr'
zstyle ':completion:*:*:ssh:*' tag-order 'users hosts:-host hosts:-domain:domain hosts:-ipaddr:ip\ addr'
zstyle ':completion:*:*:(scp|ssh):*' group-order files users hosts-host hosts-domain hosts-ipaddr

zstyle ':completion:*:*:(scp|ssh):*:hosts-host' ignored-patterns '*.*' loopback localhost
zstyle ':completion:*:*:(scp|ssh):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^*.*' '*@*'
zstyle ':completion:*:*:(scp|ssh):*:hosts-ipaddr' ignored-patterns '^<->.<->.<->.<->' '127.0.0.<->'

# Applications + extras
if type virtualenvwrapper_lazy.sh &> /dev/null; then
   export VIRTUAL_ENV_DISABLE_PROMPT=1
   . virtualenvwrapper_lazy.sh
fi

# [[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)"

ADOTDIR="$HOME/.zsh/antigen"
. "$HOME/.zsh/antigen.zsh"
antigen bundle "https://github.com/zsh-users/zsh-syntax-highlighting"
antigen apply

# Additional auticompletions
if [[ $commands[kubectl] ]]; then
   . <(kubectl completion zsh)
fi
if [[ $commands[helm] ]]; then
   . <(helm completion zsh)
fi

# ZSH highlighter coloring
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

ZSH_HIGHLIGHT_STYLES[bracket-error]=bg=red
ZSH_HIGHLIGHT_STYLES[unknown-token]=bg=red

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=red
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=blue

ZSH_HIGHLIGHT_STYLES[alias]=fg=green
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
ZSH_HIGHLIGHT_STYLES[command]=fg=green
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[function]=fg=green
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline

ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=magenta
ZSH_HIGHLIGHT_STYLES[assign]=fg=red

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta

ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue

ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_approx]=fg=yellow,underline
ZSH_HIGHLIGHT_STYLES[path_prefix]=underline

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[commandseparator]=none

#
# ZLE configuration
#
# Color Guide (for prompts):
# - Primary Colors
#   Blue  => Generic Values
#   Red   => Bad/Warning/Critical Values
#   Green => Good/Okay Values
# - Secondary Colors
#   Yellow  ( red/green )   => Label
#   Magenta ( red/blue )    => Secondary Label/Tertiery Value
#   Cyan    ( green/blue )  => Secondary Generic Value
bindkey -v
export KEYTIMEOUT=1

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:*' actionformats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u|%F{red}%a%f]'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}•%f'

function preexec() {
}

function precmd () {
   vcs_info
}

function _construct_right_prompt {
   # TODO extract all this

   local virtualenv=''
   if [[ -n "$VIRTUAL_ENV" ]]; then
      virtualenv="[%F{yellow}venv/%f%F{cyan}$(basename $VIRTUAL_ENV)%f]"
   fi

   local rbenv=''
   if type rbenv &> /dev/null; then
      # the next two lines were shamelessly taken from oh-my-zsh
      local current_ruby=$(rbenv version-name)
      local current_gemset=$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)

      if [[ -n $current_gemset ]]; then
         rbenv="[%F{yellow}rbenv%f/%F{cyan}$current_ruby%f/%F{magenta}$current_gemset%f]"
      elif [[ $current_ruby != system ]]; then
         rbenv="[%F{yellow}rbenv%f/%f%F{cyan}$current_ruby%f]"
      fi
   fi

   echo "${vcs_info_msg_0_}${virtualenv}${rbenv}"
}

function _construct_left_prompt {
   local indicator
   if [[ "$KEYMAP" == "vicmd" ]]; then
      indicator="%F{white}%B•%b%f"
   else
      indicator="%F{white}%(!.#.%%)%f"
   fi
   echo "%F{yellow}%n%f@%F{magenta}%m%f %F{blue}%(4~:.../:)%3~%f${indicator} "
}

PS1='$(_construct_left_prompt)'
RPS1='$(_construct_right_prompt)'

function zle-line-init {
}

function zle-keymap-select {
   zle reset-prompt
   zle -R
}
zle -N zle-line-init
zle -N zle-keymap-select

zmodload zsh/terminfo # Gives us $terminfo

# Keybindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M viins "^A" _next_tags

bindkey -sM vicmd '^[' '^G' # Rebind ESC to Bell in cmd mode
bindkey -rM viins '^X' # Unbind self-insert to allow the other ^X binds to work

# Add additional FZF keybindings and autocompletion after initing vimode
if [[ -e "$HOME/.fzf.zsh" ]]; then
   . "$HOME/.fzf.zsh"
fi

#
# Aliases
#

if [[ $(uname -s) == 'Darwin' ]]; then
   alias ls='ls -G'
   export GREP_OPTIONS="--color=always"
else
   alias ls='ls --color'
   alias grep='grep --color=auto'
fi
alias l='ls -h'
alias la='ls -Ah'
alias ll='ls -lh'
alias lla='ls -lAh'

# I really liked this from oh-my-zsh
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias d='dirs -v | head -10'
