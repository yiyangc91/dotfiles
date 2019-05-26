if [[ $(uname -s) == 'Darwin' ]]; then
   alias ls='ls -G'
else
   alias ls='ls --color'
fi

alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
