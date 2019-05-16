if (( $+commands[rbenv] )); then
   lazy_load load_rbenv rbenv

   function load_rbenv() {
      eval "$(rbenv init -)"
   }

   alias res='rbenv shell'
fi

function rbenv_prompt_info(){
   if type rbenv &> /dev/null; then
      # the next two lines were shamelessly taken from oh-my-zsh
      local current_ruby=$(rbenv version-name)
      local current_gemset=$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)

      if [[ -n $current_gemset ]]; then
         echo "[%F{yellow}rbenv%f/%F{cyan}$current_ruby%f/%F{magenta}$current_gemset%f]"
      elif [[ $current_ruby != system ]]; then
         echo "[%F{yellow}rbenv%f/%f%F{cyan}$current_ruby%f]"
      fi
   fi
}
