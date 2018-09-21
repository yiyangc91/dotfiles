if (( $+commands[fasd] )); then
   __FASD_CACHE="${_YIYANG_ZSH_CACHE_DIR}/fasd-init-cache"

   if [ fasd -nt "$__FASD_CACHE" -o ! -s "$__FASD_CACHE" ]; then
      fasd --init auto >| "$__FASD_CACHE"
   fi

   [[ -f $__FASD_CACHE ]] && source $__FASD_CACHE

   unset __FASD_CACHE

   alias v="f -e \"$EDITOR\""
   alias o='a -e xdg-open'
fi
