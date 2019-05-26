# opt for the /usr/share version first

__FZF_LOADED=false
if [[ -e "/usr/share/fzf/completion.zsh" ]]; then
   . "/usr/share/fzf/completion.zsh"
   __FZF_LOADED=true
fi
if [[ -e "/usr/share/fzf/key-bindings.zsh" ]]; then
   . "/usr/share/fzf/key-bindings.zsh"
   __FZF_LOADED=true
fi


if ! $__FZF_LOADED && [[ -e "$HOME/.fzf.zsh" ]]; then
   . "$HOME/.fzf.zsh"
fi
