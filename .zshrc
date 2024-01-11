# Source zsh plugins
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/scripts/colored-man-pages.plugin.zsh  # https://github.com/ael-code/zsh-colored-man-pages
source $HOME/.fzf.zsh  # TODO: I need to do this with homebrew
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Better history
export HISTFILESIZE=1000000
export HISTSIZE=1000000

setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY

# Load prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=
PURE_PROMPT_VICMD_SYMBOL=V

# Define aliases
alias s="kitty +kitten ssh"
alias fzfh="cat ~/.zsh_history | fzf"
alias n="nnn"
alias vw="nvim ~/vimwiki/index.wiki"
alias lz="lazygit"
alias home="cd ~"
alias ..="cd .."
alias ls="ls -G"
alias ll="ls -lh"
alias toipe="toipe -n 40 -w top1000"
alias dsf="diff-so-fancy"
alias satdev='s -i "/Users/borjacastillo/Documents/at3w/borjaInstance.pem" ec2-user@52.31.41.172'
alias satprod='s -i "/Users/borjacastillo/Documents/at3w/borjaInstance.pem" ec2-user@18.202.83.69'
alias satubuntu='echo Password:IoT_2017_Nc4 && s tsegui@192.168.210.43'

# Git aliases
alias add="git add"
alias commit="git commit"
alias pull="git pull"
alias stat="git status"
alias gdiff="git diff HEAD"
alias vdiff="git difftool HEAD"
alias log="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias push="git push"

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

py() {
    version=${1:0:1}.${1:1}
    command="docker run -it --rm -v .:/code -v ~/.aws:/root/.aws python:$version /bin/bash"
    echo "$command"
    eval "$command"
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

# >>> conda initialize >>>
__conda_setup="$('/Users/borjacastillo/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/borjacastillo/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/borjacastillo/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/borjacastillo/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/Library/TeX/texbin:$PATH"
export PATH="$HOME/miniforge3/bin:/usr/local/anaconda3/bin:$PATH"
export EDITOR="$(which nvim)"
export PATH="/usr/local/mysql/bin:$PATH"

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
