unsetopt correct_all
unsetopt correct
ZSH=$HOME/.oh-my-zsh
export EDITOR="vim"

plugins=(git mercurial)

source $ZSH/oh-my-zsh.sh

asend() { send "$*" && mplayer '/home/m/apps/consider_it_done.mp3'; }


send() { notify-send -i '/home/m/.send_img.png' "$*" "$(eval "$*" 2>/dev/null | tail -4)"; }
send-fail() { notify-send -i '/home/m/.send_fail_img.png' "$*" "$(eval "$*" 2>/dev/null | tail -4)"; }


alias zork='frotz ~/.wine/drive_c/GOG\ Games/Zork\ Anthology/Zork/DATA/ZORK1.DAT'
alias locate='locate -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grepi='grep -i'
alias grepr='grep -R'
alias grepri='grep -Ri'
alias grepn='grep -n'
alias grepni='grep -ni'
alias greprni='grep -Rni'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sagu='sudo apt-get update'
alias sagr='sudo apt-get upgrade'
alias sagi='sudo apt-get install'
alias sacs='sudo apt-cache search'
alias sagp='sudo apt-get purge'
alias sd='svn diff --diff-cmd=/home/m/apps/svn-diff-meld'
alias dstx='cd ~/Projects/stx/jv-branch/'
alias dlibrun='dstx; cd build/stx/librun'
alias dstc='dstx; cd build/stx/stc'
alias stx='/home/m/Projects/stx/jv-branch/build/stx/projects/smalltalk/smalltalk --cgdb'
alias dlibjava='dstx; cd build/stx/libjava'
alias dgplus='cd /home/m/Projects/ruby/gplus/'
alias dhotelline='cd /home/m/Projects/ruby/hotelline/'
alias a='ack-grep'
alias brake='bundle exec rake'
alias sails='spring rails'
alias sake='spring rake'
alias wim='cd /home/m/w; vim index.md'
alias solarized_light='/home/m/Projects/clones/gnome-terminal-colors-solarized/set_light.sh'
alias solarized_dark='/home/m/Projects/clones/gnome-terminal-colors-solarized/set_dark.sh'
alias s='git s'
alias f='fg'
alias e='exit'
alias v='vim'
alias a='git add -p'
alias c='git c'
alias gl='git pull'
alias gp='git push'
alias pp='git pull && git push'
alias dbooster='cd ~/Projects/java/bbooster'
alias drbooster='cd ~/Projects/ruby/booster'
alias dthesis='cd ~/Projects/writings/hlopko_thesis_14'
alias what_i_do='tail -n 2000 ~/.zsh_history | cut -d ";" -f 2 | awk "{print $1 $2}" | sort | uniq -c | sort -n'
alias logs.booster="ssh bwnet 'tail -f /var/log/bbooster/bbooster-trace-logfile.log'"
alias logs.booster.beta="ssh bwnet 'tail -f /var/log/bbooster/bbooster-beta-trace-logfile.log'"
alias logs.less.booster="ssh bwnet 'less /var/log/bbooster/bbooster-trace-logfile.log'"
alias logs.less.booster.beta="ssh bwnet 'less /var/log/bbooster/bbooster-beta-trace-logfile.log'"
alias bi="bundle install --standalone"

if [ -d $HOME/Projects/stx/jv-branch/build/stx/projects/smalltalk ]; then
  PATH=$PATH:$HOME/Projects/stx/jv-branch/build/stx/projects/smalltalk #add stx binary to path
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin" #add my scripts folder
fi

if [[ $LOGNAME == 'm' ]]; then
	source ~/bin/nice_prompt #show cool command prompt
fi

bindkey '\e[3~' delete-char #make del working
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

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/lib/go/bin:$PATH"

export RI="--format ansi --width 70"

autoload -U zmv
