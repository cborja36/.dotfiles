# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/borjacastillo/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/borjacastillo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/borjacastillo/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/borjacastillo/.fzf/shell/key-bindings.zsh"
