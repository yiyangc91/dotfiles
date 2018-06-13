# PATH
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.rbenv/bin" ]] && PATH="$HOME/.rbenv/bin:$PATH"
[[ -d "$HOME/.cabal/bin" ]] && PATH="$HOME/.cabal/bin:$PATH"
[[ -d "$HOME/go" ]] && {
   export GOPATH="$HOME/go"
   PATH="$PATH:$GOPATH/bin"
}

export PATH

# Debian compinit is pointless
skip_global_compinit=1

# OSX fun + fix the java version
# Unfuck me later
if [[ $(uname -s) == 'Darwin' ]]; then
   export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Pick up local zsh stuff, things we want separated per computer
if [[ -e "$HOME/.zshlocalenv" ]]; then
   . "$HOME/.zshlocalenv"
fi

