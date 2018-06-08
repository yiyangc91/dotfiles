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

_YIYANG_ZSH_PLUGIN_ZSH_SYNTAX_HIGHLIGHTING_DIR="$_YIYANG_ZSH_PLUGINS_DIR/zsh-syntax-highlighting.git"
if [[ ! -d "$_YIYANG_ZSH_PLUGIN_ZSH_SYNTAX_HIGHLIGHTING_DIR" ]]; then
   git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$_YIYANG_ZSH_PLUGIN_ZSH_SYNTAX_HIGHLIGHTING_DIR"
fi
_YIYANG_ZSH_PLUGIN_ZSH_COMPLETIONS_DIR="$_YIYANG_ZSH_PLUGINS_DIR/zsh-completions.git"
if [[ ! -d "$_YIYANG_ZSH_PLUGIN_ZSH_COMPLETIONS_DIR" ]]; then
   git clone --depth 1 https://github.com/zsh-users/zsh-completions.git "$_YIYANG_ZSH_PLUGIN_ZSH_COMPLETIONS_DIR"
fi

# If this is a symlink we also need to create the link for lib
(
   if [[ -L "$HOME/.zshrc" ]]; then
      zshsrcdir=$(dirname $(readlink .zshrc))

      # If there's no lib then link it otherwise don't touch
      [[ -e "$_YIYANG_ZSH/lib" ]] || ln -s "$zshsrcdir/.zsh/lib" "$_YIYANG_ZSH/lib"
   fi
)

# TODO: Figure out where to put these options
unsetopt flow_control # disables ^S and ^Q for controlling terminal output

# Load libs
. "$_YIYANG_ZSH/lib/correction.zsh"
. "$_YIYANG_ZSH/lib/completion.zsh"
. "$_YIYANG_ZSH/lib/history.zsh"
. "$_YIYANG_ZSH/lib/keybinds.zsh"
. "$_YIYANG_ZSH/lib/pushd.zsh"

# Turns out, antigen fucks with completion
# I've decided to nuke it
# Just source plugins directly
source $_YIYANG_ZSH_PLUGIN_ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.plugin.zsh
source $_YIYANG_ZSH_PLUGIN_ZSH_COMPLETIONS_DIR/zsh-completions.plugin.zsh

. "$_YIYANG_ZSH/lib/plugins/zsh-syntax-highlighting.zsh"

# Things which configure various external tools
. "$_YIYANG_ZSH/lib/opt/fzf.zsh"
. "$_YIYANG_ZSH/lib/opt/grep.zsh"
. "$_YIYANG_ZSH/lib/opt/helm.zsh"
. "$_YIYANG_ZSH/lib/opt/kubectl.zsh"
. "$_YIYANG_ZSH/lib/opt/ls.zsh"
. "$_YIYANG_ZSH/lib/opt/rbenv.zsh"
. "$_YIYANG_ZSH/lib/opt/virtualenv.zsh"
. "$_YIYANG_ZSH/lib/opt/virtualenvwrapper.zsh"

# Load the prompt last because we might rely on external things
. "$_YIYANG_ZSH/lib/prompt.zsh"
