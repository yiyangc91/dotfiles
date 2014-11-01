# Some basic checking
[[ -d "$HOME/.zsh/cache" ]] || echo 'Warning: Cache directory is missing' >&2
[[ -d "$HOME/.zsh" ]] || echo 'Warning: ZSH directory is missing' >&2


HISTFILE="$HOME/.zsh/histfile"
HISTSIZE=16384
SAVEHIST=16384
DIRSTACKSIZE=20

setopt auto_cd # cd just by using dirname
setopt auto_pushd # auto pushd, it's like browser history.
setopt pushd_ignore_dups # ignore dups in pushd
setopt pushd_silent # stfu

setopt hist_ignore_dups # ignore dups in history so we dont end up scrolling for years
setopt hist_verify # !command verification, ensures no accidents
setopt share_history # amazing. "implies" append_history and extended_history

setopt prompt_subst # allows prompt to work

setopt correct # like the arch setup terminal

unsetopt flow_control # annoying

# ZLE configuration
bindkey -v

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:*' actionformats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u|%F{red}%a%f]'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}•%f'
precmd () { vcs_info }

function zle-line-init zle-keymap-select {
   local indicator
   local virtualenv=''

   if [[ "$KEYMAP" == "vicmd" ]]; then
      indicator="%F{magenta}⌘%f"
   else
      indicator="%(?.%F{green}.%F{red})%(!.#.%%)%f"
   fi

   if [[ -n "$VIRTUAL_ENV" ]]; then
      virtualenv="[%F{yellow}virtualenv/%f%F{cyan}$(basename $VIRTUAL_ENV)%f]"
   fi

   PS1="%B%F{black}%*%f%b %F{blue}%(4~:.../:)%3~%f${indicator} "
   RPS1="${vcs_info_msg_0_}${virtualenv}"

   zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M viins "^R" history-incremental-search-backward

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Completion Configuration
zmodload -i zsh/complist

autoload -Uz compinit
compinit -d ~/.zsh/zcompdump

zstyle ':completion:*' menu select # like vim's wildmenu
zstyle ':completion:*' list-colors '' # avoid setting ZLS_COLORS for complist
zstyle ':completion:*' rehash yes # zsh can't find new programs
zstyle ':completion:*' list-prompt '%S%M matches%s' # page matches
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

zstyle ':completion:*' verbose yes
zstyle ':completion:*' auto-description 'specify: %d'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Aliases
if [[ $(uname -s) == 'Darwin' ]]; then
   alias ls='ls -G'
else
   alias ls='ls --color'
fi
alias l='ls -h'
alias la='ls -Ah'
alias ll='ls -lh'
alias lla='ls -lAh'

# Applications and stuff
if type virtualenvwrapper.sh &> /dev/null; then
   . virtualenvwrapper.sh
fi

[[ -f "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Pick up local zsh stuff, things we want separated per computer
if [[ -f "$HOME/.zshlocal" ]]; then
   . "$HOME/.zshlocal"
fi
