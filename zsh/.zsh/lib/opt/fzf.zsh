if [[ -e "$HOME/.fzf.zsh" ]]; then
   . "$HOME/.fzf.zsh"
fi

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"
