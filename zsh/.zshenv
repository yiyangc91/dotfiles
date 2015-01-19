export EDITOR=vim
export PAGER=less

# Our home binaries first.
# Make sure this directory is chmodded properly!
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

# Then append RVM/Cabal/etc at the end
[[ -d "$HOME/.cabal/bin" ]] && PATH="$PATH:$HOME/.cabal/bin"
[[ -d "$HOME/.rvm/bin" ]] && PATH="$PATH:$HOME/.rvm/bin"

export PATH

# OSX fun + fix the java version
# Unfuck me later
if [[ $(uname -s) == 'Darwin' ]]; then
   export JAVA_HOME=$(/usr/libexec/java_home)
fi
