# Set up the prompt

autoload -Uz colors && colors
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

unsetopt correct_all
unsetopt correct
ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export GYP_GENERATORS=ninja
export GYP_CHROMIUM_NO_ACTION=1
export NINJA_STATUS="[%f/%r/%u] "

plugins=(git mercurial)
export ZSH_THEME=sunrise

source $ZSH/oh-my-zsh.sh

alias sagu='sudo apt-get update'
alias sagr='sudo apt-get upgrade'
alias sagi='sudo apt-get install'
alias sacs='sudo apt-cache search'
alias sagp='sudo apt-get purge'
alias dv8='cd ~/projects/v8/v8'
alias dchrome='cd ~/projects/chromium/src'
alias dblaze='cd ~/projects/blaze/google3'
alias dbazel='cd ~/projects/bazel'
alias s='git s'
alias e='exit'
alias a='git add -p'
alias c='git c'
alias gl='git pull'
alias gp='git push'
alias pp='git pull && git push'
alias tmux='TERM=xterm-256color tmux -2'
alias ag='ag -i'
alias ll='ls -la'
alias bz='bazel build //src:bazel'
alias bb='bazel build //src:bazel'
alias bzl='~/projects/bazel/bazel-bin/src/bazel'

hr(){printf '\e[32m━%.0s\e[39m' $(seq $COLUMNS)}

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/.cargo/bin:$HOME/bin:$HOME/projects/arc/arcanist/bin"
fi

if [ -d /usr/local/google/home/hlopko/depot_tools ] ; then
  PATH="/usr/local/google/home/hlopko/depot_tools:$PATH"
fi

# bindkey '\e[3~' delete-char #make del working
bindkey '^R' history-incremental-search-backward #bind rev-search to ctrl-r
typeset -A key

#make some chars behaving nicely
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

# if [[ -f ~/bin/nice_prompt ]]; then
	source ~/bin/nice_prompt
# fi
#
source /etc/bash_completion.d/g4d

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

source ~/.dev_functions

export REPORTTIME=3
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/google/home/${USER}/yourkit/bin/linux-x86-64/


# The next line updates PATH for the Google Cloud SDK.
if [ -f /usr/local/google/home/hlopko/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/usr/local/google/home/hlopko/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /usr/local/google/home/hlopko/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/usr/local/google/home/hlopko/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

eval `dircolors ~/.dir_colors/dircolors`
export PATH="/usr/local/google/home/hlopko/projects/clones/arc/arcanist/bin:$PATH"
export ANDROID_HOME="$(echo $HOME)/Android/Sdk"
export ANDROID_NDK_HOME="$(echo $HOME)/Android/Sdk/ndk-bundle"

source /usr/local/share/chruby/chruby.sh

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH:$HOME/go/bin"
# export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh


function fix_capslock() {
  setxkbmap -layout us -option ctrl:nocaps
}
