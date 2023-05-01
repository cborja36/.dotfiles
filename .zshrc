# Source zsh plugins
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/scripts/colored-man-pages.plugin.zsh  # https://github.com/ael-code/zsh-colored-man-pages
source $HOME/.fzf.zsh  # TODO: I need to do this with homebrew
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=
PURE_PROMPT_VICMD_SYMBOL=V

# Define aliases
alias n="nnn"
alias lz="lazygit"
alias cls="clear"
alias home="cd ~"
alias ..="cd .."
alias ls="ls -G"
alias ll="ls -lh"

# Define functions
brew() {
  command brew "$@" 
  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

ca() {
    env_name=$(conda env list | grep '/' | fzf | cut -d ' ' -f 1)
    if [ -z "$env_name" ]; then
        echo "Environment selection canceled."
    else
        conda activate "$env_name"
    fi
}

cdp () {
    paths_documents="$(find ~/Documents -maxdepth 2 -type d -not -path '*/\.*' | sed "s|$HOME|~|")"
    paths_downloads="$(find ~/Downloads -maxdepth 2 -type d -not -path '*/\.*' | sed "s|$HOME|~|")"
    paths_desktop="$(find ~/Desktop -maxdepth 2 -type d -not -path '*/\.*' | sed "s|$HOME|~|")"
    paths_dotfiles="$(find ~/.dotfiles -maxdepth 2 -type d -not -path '*/\.git*' | sed "s|$HOME|~|")"
    paths="$paths_documents\n$paths_downloads\n$paths_desktop\n$paths_dotfiles"
    selected_dir=$(echo $paths | fzf)
    if [ -n "$selected_dir" ]; then
        selected_dir=$(echo "$selected_dir" | sed "s|~|$HOME|")
        cd "$selected_dir"
    else
        echo "No directory selected."
    fi
}

ob() {
    selected_book=$(find ~/Calibre\ Library -name '*.pdf' | cut -d '/' -f 7- | fzf)
    if [ -n "$selected_book" ]; then
        open "$(find ~/Calibre\ Library -name $selected_book)"
    fi
}

# Prevent nested instances of neovim
if [ -n "$VIMRUNTIME" ]; then 
  if [ -x "$(command -v nvr)" ]; then 
    alias nvim=nvr 
  else 
    alias nvim='echo "No nesting!"' 
  fi 
fi

if [ -z "$VIMRUNTIME" ]; then
  export VISUAL='nvim'
fi

# Change path
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$HOME/miniforge3/bin:/usr/local/anaconda3/bin:$PATH"
export EDITOR="$(which nvim)"
