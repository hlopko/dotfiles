unsetopt correct_all
unsetopt correct
ZSH=$HOME/.oh-my-zsh
export EDITOR="vim"

plugins=(git)

source $ZSH/oh-my-zsh.sh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


alias tmux="TERM=screen-256color-bce tmux"
asend() { send "$*" && mplayer '/home/m/apps/consider_it_done.mp3'; }


send() { notify-send -i '/home/m/.send_img.png' "$*" "$(eval "$*" 2>/dev/null | tail -4)"; }
send-fail() { notify-send -i '/home/m/.send_fail_img.png' "$*" "$(eval "$*" 2>/dev/null | tail -4)"; }


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
alias dblog='cd /home/m/Projects/writings/mhlopko.github.com'
alias stx='/home/m/Projects/stx/jv-branch/build/stx/projects/smalltalk/smalltalk -I --quick'
alias update_stx='dstc; svn update; make; dlibrun; svn update; make; dstx; svn update; brake update compile'
alias dlibjava='dstx; cd build/stx/libjava'
alias dthesis='cd /home/m/Projects/thesis/latex'
alias desug12='cd /home/m/Projects/writings/libjava-ESUG2012'
alias dreload='cd /home/m/Projects/writings/reloading_for_wapl2013'
alias drails='cd /home/m/Projects/ruby/'
alias dgplus='cd /home/m/Projects/ruby/gplus/'
alias dlibjava2='cd /home/m/Projects/stx/libjava/branches/jk_new_structure'
alias cssh.bonus='ssh marcel@bonus.tiscali.cz'
alias cssh.shared='ssh marcel@shared.city4web.cz -p 22443'
alias cssh.swing='ssh hlopkmar@swing.fit.cvut.cz'
alias cssh.develop='ssh marcel@develop.city4web.cz -p 22443'
alias cssh.albumplus='ssh albumplus_cz@83.167.247.210 -p 22443'
alias a='ack-grep'
alias dcommit_and_back='git co master && git merge working && git svn dcommit && git co working && git rebase master'
alias brake='bundle exec rake'
alias sails='spring rails'
alias sake='spring rake'
alias wim='cd /home/m/w; vim index.md'
alias solarized_light='/home/m/Projects/clones/gnome-terminal-colors-solarized/set_light.sh'
alias solarized_dark='/home/m/Projects/clones/gnome-terminal-colors-solarized/set_dark.sh'

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

export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.25
export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_FREE_MIN=600000

export RI="--format ansi --width 70"
