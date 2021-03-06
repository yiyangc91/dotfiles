# Stolen and modified from oh-my-zsh

if (( $+commands[kubectl] )); then
   lazy_load load_kubectl kubectl

   function load_kubectl() {
      __KUBECTL_COMPLETION_FILE="${_YIYANG_ZSH_CACHE_DIR}/kubectl_completion"

      if [[ ! -f $__KUBECTL_COMPLETION_FILE ]]; then
         kubectl completion zsh >! $__KUBECTL_COMPLETION_FILE
      fi

      [[ -f $__KUBECTL_COMPLETION_FILE ]] && source $__KUBECTL_COMPLETION_FILE

      unset __KUBECTL_COMPLETION_FILE
   }

   # This command is used ALOT both below and in daily life
   alias k=kubectl
   alias kaf='k apply -f'
   alias kl='k logs'

   # kubectl get various things
   alias kg='k get'
   alias kga="kubectl get --all-namespaces"

   alias kgsi='k get serviceinstances'
   alias kgsb='k get servicebindings'
   alias kgst='k get state'
   alias kgbu='k get bundle'
   alias kgsec='k get secret'

   # kubectl get pods
   alias kgp='k get pods'
   alias kgpy="k get pod -o yaml"
   alias kgap="k get pods --all-namespaces"

   # kubectl
   alias kl="kubectl logs"

   # kubectx and kubens
   alias kx="kubectx"
   alias kn="kubens"

   # # Drop into an interactive terminal on a container
   # alias keti='k exec -ti'

   # # Manage configuration quickly to switch contexts between local, dev ad staging.
   # alias kcuc='k config use-context'
   # alias kcsc='k config set-context'
   # alias kcdc='k config delete-context'
   # alias kccc='k config current-context'

   # # Pod management.
   # alias kgp='k get pods'
   # alias kep='k edit pods'
   # alias kdp='k describe pods'
   # alias kdelp='k delete pods'

   # # Service management.
   # alias kgs='k get svc'
   # alias kes='k edit svc'
   # alias kds='k describe svc'
   # alias kdels='k delete svc'

   # # Ingress management
   # alias kgi='k get ingress'
   # alias kei='k edit ingress'
   # alias kdi='k describe ingress'
   # alias kdeli='k delete ingress'

   # # Secret management
   # alias kgsec='k get secret'
   # alias kdsec='k describe secret'
   # alias kdelsec='k delete secret'

   # # Deployment management.
   # alias kgd='k get deployment'
   # alias ked='k edit deployment'
   # alias kdd='k describe deployment'
   # alias kdeld='k delete deployment'
   # alias ksd='k scale deployment'
   # alias krsd='k rollout status deployment'

   # # Rollout management.
   # alias kgrs='k get rs'
   # alias krh='k rollout history'
   # alias kru='k rollout undo'

   # Logs
   # alias klf='k logs -f'
fi
