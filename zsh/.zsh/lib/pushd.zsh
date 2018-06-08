setopt auto_cd # cd just by using dirname
setopt auto_pushd # auto pushd, it's like browser history.
setopt pushd_ignore_dups # ignore dups in pushd
setopt pushd_silent # do not print directory stack after pushd or popd
setopt pushd_minus # - easier to type than + (i.e. reverses cd -1 instead of cd +1)
export DIRSTACKSIZE=20

# Stolen from oh-my-zsh
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

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
