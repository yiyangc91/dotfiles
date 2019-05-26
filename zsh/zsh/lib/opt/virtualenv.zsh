function virtualenv_prompt_info(){
   if [[ -n "$VIRTUAL_ENV" ]]; then
      echo "[%F{yellow}venv/%f%F{cyan}$(basename $VIRTUAL_ENV)%f]"
   fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
