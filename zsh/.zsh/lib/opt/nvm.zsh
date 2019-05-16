if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
   lazy_load load_nvm nvm

   function load_nvm() {
      [[ -z "$__NVM_DIR" ]] && export __NVM_DIR="$HOME/.nvm"
      [[ -s "$__NVM_DIR/nvm.sh" ]] && source "$__NVM_DIR/nvm.sh" --no-use
      unset __NVM_DIR
   }
fi

function nvm_prompt_info() {
   if type nvm &> /dev/null; then
      local current_node=${NVM_BIN%/bin}
      current_node=${current_node##*/}

      if [[ $current_node != system && ! -z $current_node ]]; then
         echo "[%F{yellow}nvm%f/%f%F{cyan}$current_node%f]"
      fi
   fi
}
