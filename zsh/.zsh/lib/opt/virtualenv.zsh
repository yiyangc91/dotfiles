function virtualenv_prompt_info(){
   if [[ -n "$VIRTUAL_ENV" ]]; then
      echo "[%F{yellow}venv/%f%F{cyan}$(basename $VIRTUAL_ENV)%f]"
   fi
}

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1
