autoload -Uz colors && colors
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

unsetopt correct_all
unsetopt correct
ZSH=$HOME/.oh-my-zsh

export EDITOR='nvim'

plugins=(git cargo rust command-not-found github)

source $ZSH/oh-my-zsh.sh

alias dbazel='cd ~/projects/bazel'
alias s='git s'
alias e='exit'
alias a='git add --all -p'
alias c='git c'
alias gd='git diff'
alias wip='git c --amend --no-edit'
alias tmux='TERM=xterm-256color tmux -2'
alias ll='ls -la'
alias bz='bazel build //src:bazel -c opt'
alias bb='blaze build //devtools/blaze -c opt'
alias bzl='~/projects/bazel/bazel-bin/src/bazel'

hr(){printf '\e[32m━%.0s\e[39m' $(seq $COLUMNS)}

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/.cargo/bin:$HOME/bin:$HOME/projects/swift/build/Ninja-RelWithDebInfoAssert/swift-linux-x86_64/bin"
fi

# bindkey '\e[3~' delete-char #make del working
bindkey '^R' history-incremental-search-backward #bind rev-search to ctrl-r
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
  function zle-line-init () {
    echoti smkx
  }
  function zle-line-finish () {
    echoti rmkx
  }

  zle -N zle-line-init
  zle -N zle-line-finish
fi

if [[ -f ~/bin/nice_prompt ]]; then
	source ~/bin/nice_prompt
fi

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

autoload -U zmv

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Reset
export COLOR_OFF='\033[0m'       # Text Reset

# Regular Colors
export BLACK='\033[0;30m'        # Black
export RED='\033[0;31m'          # Red
export GREEN='\033[0;32m'        # Green
export YELLOW='\033[0;33m'       # Yellow
export BLUE='\033[0;34m'         # Blue
export PURPLE='\033[0;35m'       # Purple
export CYAN='\033[0;36m'         # Cyan
export WHITE='\033[0;37m'        # White

# Bold
export BBLACK='\033[1;30m'       # Black
export BRED='\033[1;31m'         # Red
export BGREEN='\033[1;32m'       # Green
export BYELLOw='\033[1;33m'      # Yellow
export BBLUE='\033[1;34m'        # Blue
export BPURPLe='\033[1;35m'      # Purple
export BCYAN='\033[1;36m'        # Cyan
export BWHITE='\033[1;37m'       # White

[ -f ~/.dev_functions ] && source ~/.dev_functions

export REPORTTIME=3

function fix_capslock() {
  setxkbmap -layout us -option ctrl:nocaps
}
work() { tmx2 new-session -A -s ${1:-work}; }

source /etc/bash_completion.d/g4d

