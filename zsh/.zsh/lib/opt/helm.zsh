if (( $+commands[helm] )); then
    __HELM_COMPLETION_FILE="${_YIYANG_ZSH_CACHE_DIR}/helm_completion"

    if [[ ! -f $__HELM_COMPLETION_FILE ]]; then
        helm completion zsh >! $__HELM_COMPLETION_FILE
    fi

    [[ -f $__HELM_COMPLETION_FILE ]] && source $__HELM_COMPLETION_FILE

    unset __HELM_COMPLETION_FILE
fi
