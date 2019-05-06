# stolen from oh-my-zsh

if (( $+commands[pyenv] )); then
   # This is for Linux. OSX brew path should be there already.
   pyenvdirs=("$HOME/.pyenv" "/usr/local/pyenv" "/opt/pyenv")
   for dir in $pyenvdirs; do
      if [[ -d $dir/bin ]]; then
         export PATH="$PATH:$dir/bin"
         break
      fi
   done

   eval "$(pyenv init - zsh)"
   if (( $+commands[pyenv-virtualenv-init] )); then
      eval "$(pyenv virtualenv-init - zsh)"
   fi

   alias pes='pyenv shell'
   alias pea='pyenv activate'
   alias ped='pyenv deactivate'
   alias pev='pyenv virtualenv'
fi

function pyenv_prompt_info() {
   if type pyenv &> /dev/null; then
      local current_python=$(pyenv version-name)

      if [[ $current_python != system ]]; then
         echo "[%F{yellow}pyenv%f/%f%F{cyan}$current_python%f]"
      fi
   fi
}
