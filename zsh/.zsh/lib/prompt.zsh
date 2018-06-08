# Color Guide (for prompts):
# - Primary Colors
#   Blue  => Generic Values
#   Red   => Bad/Warning/Critical Values
#   Green => Good/Okay Values
# - Secondary Colors
#   Yellow  ( red/green )   => Label
#   Magenta ( red/blue )    => Secondary Label/Tertiery Value
#   Cyan    ( green/blue )  => Secondary Generic Value

setopt prompt_subst # allows prompt to work by performing various expansions

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:*' actionformats '[%F{yellow}%s%f/%F{cyan}%b%f%c%u|%F{red}%a%f]'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}•%f'

function preexec() {
}

function precmd () {
   vcs_info
}

function _construct_right_prompt {
   local virtualenv=$(virtualenv_prompt_info)
   local rbenv=$(rbenv_prompt_info)

   # Colors schemes should be defined in one place, not all over the joint
   echo "${vcs_info_msg_0_}${virtualenv}${rbenv}"
}

function _construct_left_prompt {
   local vimode=$(vi_mode_prompt_info "%F{white}%B•%b%f" "%F{white}%(!.#.%%)%f")

   echo "%F{yellow}%n%f@%F{magenta}%m%f %F{blue}%(4~:.../:)%3~%f${vimode} "
}

PS1='$(_construct_left_prompt)'
RPS1='$(_construct_right_prompt)'
