# opt for the /usr/share version first

__FZF_LOADED=false
if ! $__FZF_LOADED && [[ -e "$HOME/.fzf.zsh" ]]; then
   . "$HOME/.fzf.zsh"
   __FZF_LOADED=true
fi

if ! $__FZF_LOADED && [[ -e "/usr/share/fzf/completion.zsh" ]]; then
   . "/usr/share/fzf/completion.zsh"
   . "/usr/share/fzf/key-bindings.zsh"
   __FZF_LOADED=true
fi

if ! $__FZF_LOADED && (( $+commands[brew] )); then
   __BREW_PREFIX="$(brew --prefix)/opt/fzf/shell"
   if [[ -e "${__BREW_PREFIX}" ]]; then
      . "${__BREW_PREFIX}/completion.zsh"
      . "${__BREW_PREFIX}/key-bindings.zsh"
      __FZF_LOADED=true
   fi
   unset __BREW_PREFIX
fi
