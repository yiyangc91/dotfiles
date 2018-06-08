if (( $+commands[minikube] )); then
    __MINIKUBE_COMPLETION_FILE="${_YIYANG_ZSH_CACHE_DIR}/minikube_completion"

    if [[ ! -f $__MINIKUBE_COMPLETION_FILE ]]; then
        minikube completion zsh >! $__MINIKUBE_COMPLETION_FILE
    fi

    [[ -f $__MINIKUBE_COMPLETION_FILE ]] && source $__MINIKUBE_COMPLETION_FILE

    unset __MINIKUBE_COMPLETION_FILE
fi
