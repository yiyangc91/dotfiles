export EDITOR=vim
export PAGER=less
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

_YIYANG_ZSH="$HOME/.zsh"
_YIYANG_ZSH_CACHE_DIR="$_YIYANG_ZSH/cache"
_YIYANG_ZSH_PLUGINS_DIR="$_YIYANG_ZSH/plugins"
_YIYANG_COMPDUMPFILE="$_YIYANG_ZSH/zcompdump"

# Local ZSH stuff
if [[ -e "$HOME/.zshlocalrc" ]]; then
   . "$HOME/.zshlocalrc"
fi

# Set up a place to dump all my ZSH stuff
[[ -d "$_YIYANG_ZSH" ]] || mkdir -p "$_YIYANG_ZSH"
[[ -d "$_YIYANG_ZSH_CACHE_DIR" ]] || mkdir -p "$_YIYANG_ZSH_CACHE_DIR"
[[ -d "$_YIYANG_ZSH_PLUGINS_DIR" ]] || mkdir -p "$_YIYANG_ZSH_PLUGINS_DIR"

# If this is a symlink we also need to create the link for lib
(
if [[ -L "$HOME/.zshrc" ]]; then
   cd "$HOME"
   rcsymlink=$(dirname $(readlink .zshrc))
   zshsrcdir=$(cd "$rcsymlink" && pwd)

   # If there's no lib then link it otherwise don't touch
   [[ -e "$_YIYANG_ZSH/lib" ]] || ln -s "$zshsrcdir/.zsh/lib" "$_YIYANG_ZSH/lib"
fi
)

# TODO: Figure out where to put these options
unsetopt flow_control # disables ^S and ^Q for controlling terminal output
unsetopt bg_nice # fix for wsl where zsh tries to nice bg processes

# Load libs
. "$_YIYANG_ZSH/lib/correction.zsh"
. "$_YIYANG_ZSH/lib/completion.zsh"
. "$_YIYANG_ZSH/lib/history.zsh"
. "$_YIYANG_ZSH/lib/keybinds.zsh"

# Turns out, antigen fucks with completion
# I've decided to nuke it
function load_plugin() {
   local plugin_repo=$1
   local sourced=$2
   local plugin_name=${1##*/}
   local _plugin_dir="$_YIYANG_ZSH_PLUGINS_DIR/$plugin_name"
   if [[ ! -d "$_plugin_dir" ]]; then
      git clone --depth 1 $plugin_repo "$_plugin_dir"
   fi
   source $_plugin_dir/$sourced
}

load_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting.plugin.zsh
load_plugin https://github.com/zsh-users/zsh-completions.git zsh-completions.plugin.zsh
_Z_DATA="$_YIYANG_ZSH/.z" load_plugin https://github.com/rupa/z.git z.sh
load_plugin https://github.com/molovo/tipz tipz.zsh

. "$_YIYANG_ZSH/lib/plugins/zsh-syntax-highlighting.zsh"

# Things which configure various external tools
. "$_YIYANG_ZSH/lib/opt/cdr.zsh"
. "$_YIYANG_ZSH/lib/opt/fzf.zsh"
. "$_YIYANG_ZSH/lib/opt/git.zsh"
. "$_YIYANG_ZSH/lib/opt/grep.zsh"
. "$_YIYANG_ZSH/lib/opt/helm.zsh"
. "$_YIYANG_ZSH/lib/opt/kubectl.zsh"
. "$_YIYANG_ZSH/lib/opt/ls.zsh"
. "$_YIYANG_ZSH/lib/opt/minikube.zsh"
. "$_YIYANG_ZSH/lib/opt/rbenv.zsh"
. "$_YIYANG_ZSH/lib/opt/virtualenv.zsh"
. "$_YIYANG_ZSH/lib/opt/virtualenvwrapper.zsh"

# Load the prompt last because we might rely on external things
. "$_YIYANG_ZSH/lib/prompt.zsh"
