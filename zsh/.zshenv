export EDITOR=vim
export PAGER=less

[[ -d "$HOME/.cabal/bin" ]] && PATH="$PATH:$HOME/.cabal/bin"
[[ -d "$HOME/.rvm/bin" ]] && PATH="$PATH:$HOME/.rvm/bin"
[[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"
export PATH

if [[ $(uname -s) == 'Darwin' ]]; then
   export JAVA_HOME=$(/usr/libexec/java_home)
fi
