# Set up a place to dump all my ZSH stuff
[[ -d "$HOME/.zsh" ]] || mkdir -p "$HOME/.zsh"
[[ -d "$HOME/.zsh/cache" ]] || mkdir -p "$HOME/.zsh/cache"
[[ -d "$HOME/.zsh/antigen" ]] || mkdir -p "$HOME/.zsh/antigen"
[[ -e "$HOME/.zsh/antigen.zsh" ]] || echo "Antigen not installed" >&2

HISTFILE="$HOME/.zsh/histfile"
HISTSIZE=16384
SAVEHIST=16384
DIRSTACKSIZE=20

setopt auto_cd # cd just by using dirname
setopt auto_pushd # auto pushd, it's like browser history.
setopt pushd_ignore_dups # ignore dups in pushd
setopt pushd_silent # stfu
setopt pushd_minus # - easier to type than +

setopt hist_ignore_dups # ignore dups in history so we dont end up scrolling for years
setopt hist_verify # !command verification, ensures no accidents
setopt share_history # amazing. "implies" append_history and extended_history

setopt prompt_subst # allows prompt to work

setopt correct # like the arch setup terminal

unsetopt flow_control # annoying

# This is not in zshenv because these are specific to interactive shells
# OSX and BSD can go die in a fire
export LSCOLORS='exfxcxdxbxbfafBxGxacae'
if ls --color=auto &> /dev/null; then
   if type dircolors &> /dev/null && [[ -f "$HOME/.dir_colors" ]]; then
      eval $(dircolors "$HOME/.dir_colors")
   else
      echo 'Warning: Using GNU coreutils but cannot do colors properly' >&2
      export LS_COLORS='rs=0:di=00;34:ln=00;35:so=00;32:pi=00;33:ex=00;31:bd=45;31:cd=45;30:su=01;31:sg=01;36:tw=42;30:ow=44;30:do=03;32:or=41;35:ca=5;47;1;32:st=1;42;32:mh=01:'
   fi
fi
export GREP_OPTIONS="--color=auto"

# We're probably on OSX/BSD
if [[ -z "$LS_COLORS" ]]; then
   export LS_COLORS='rs=0:di=00;34:ln=00;35:so=00;32:pi=00;33:ex=00;31:bd=45;31:cd=45;30:su=01;31:sg=01;36:tw=42;30:ow=44;30:'
fi

#
# ZLE configuration
#
# Color Guide:
#  Generally just pick anything that looks good:
#  - blue is reserved for directories, because there are tons of those, and
#    otherwise there's way too much blue on the screen.
#  - green and red for "good" and "alert/bad/wtf".
#  - yellow/cyan used in RPS1 as label+value. magenta for secondary label.
#    red and green also used in place of magenta as appropriate.
bindkey -v

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:*' actionformats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u|%F{red}%a%f]'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}•%f'

function preexec() {
   typeset -g CALCTIME=$2
   typeset -gi CMDSTARTTIME=SECONDS
}

function precmd () {
   vcs_info
   if [[ -n $CALCTIME ]]; then
      typeset -gi ETIME=SECONDS-CMDSTARTTIME
      if [[ ${#CALCTIME} -gt 10 ]]; then
         typeset -g ENAME=${CALCTIME:0:8}..
      else
         typeset -g ENAME=$CALCTIME
      fi
   fi
   typeset -g CALCTIME=''
}

function _construct_right_prompt {
   # TODO extract all this

   local virtualenv=''
   if [[ -n "$VIRTUAL_ENV" ]]; then
      virtualenv="[%F{yellow}venv/%f%F{cyan}$(basename $VIRTUAL_ENV)%f]"
   fi

   local executionTime=''
   if [[ $ETIME -gt 0 ]]; then
      local secondStr='sec'
      if [[ $ETIME -ne 1 ]]; then
         secondStr+='s'
      fi
      executionTime="[%F{yellow}${ENAME}%f:%F{cyan}$ETIME%f %F{magenta}${secondStr}%f]"
   fi

   echo "${executionTime}${vcs_info_msg_0_}${virtualenv}"
}

function _construct_left_prompt {
   local indicator
   if [[ "$KEYMAP" == "vicmd" ]]; then
      indicator="%F{magenta}⌘%f"
   else
      indicator="%(?.%F{green}.%F{red})%(!.#.%%)%f"
   fi
   echo "%B%F{black}%*%f%b %F{blue}%(4~:.../:)%3~%f${indicator} "
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

bindkey -M viins "^R" history-incremental-search-backward

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Completion Configuration
zmodload -i zsh/complist

autoload -Uz compinit
compinit -d ~/.zsh/zcompdump

zstyle ':completion:*' menu select # like vim's wildmenu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
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

#
# Aliases
#

# ls aliases
if [[ $(uname -s) == 'Darwin' ]]; then
   alias ls='ls -G'
else
   alias ls='ls --color'
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

# Applications and stuff
if type virtualenvwrapper.sh &> /dev/null; then
   . virtualenvwrapper.sh
fi

[[ -f "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

ADOTDIR="$HOME/.zsh/antigen"
. "$HOME/.zsh/antigen.zsh"
antigen bundle "git@github.com:zsh-users/zsh-syntax-highlighting.git"
antigen apply

# Pick up local zsh stuff, things we want separated per computer
if [[ -e "$HOME/.zshlocal" ]]; then
   . "$HOME/.zshlocal"
fi
