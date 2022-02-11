# Brew nvm Caveats
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Pretty prompt
BLUE="\[\e[36m\]"
RED="\[\e[91m\]"
DEFAULT="\[\e[m\]"
export PS1="\$([[ \$? == 0 ]] && printf $BLUE || printf $RED)[\t \W]\$ $DEFAULT"

# Pretty ls
export LSCOLORS='Exfxcxdxbxegedabagacad'

# Sample tmux split window
two_windows() {
  tmux -CC \
    new-session "true; echo Exited.; read" \; \
    split-window "true; echo Exited.; read" \;
}

# Sample tmux single window
one_window() {
  tmux -CC \
    new-session "true; echo Exited.; read" \;
}

# More memory for React
export NODE_OPTIONS='--max_old_space_size=4096'

# fuck
eval "$(thefuck --alias)"

# Aliases
alias reload="exec -l $SHELL"
alias ls='ls -G'
alias ll='ls -lahH'
alias yll='find node_modules -type l -maxdepth 3 | grep -v .bin | cut -f2- -d/'

alias awho='aws sts get-caller-identity'


# remove local branches that are deleted in remote
alias git_clean="git fetch -p && git branch -vv | .bashgrep ': gone]' | awk '{print \$1}' | xargs git branch -D"
# rebases current branch again remote master@head
alias git_rebase_at_master="git fetch origin master && git rebase origin/master"

# Functions
aws_profiles () {
  [[ -r "${AWS_CONFIG_FILE:-$HOME/.aws/config}" ]] || return 1
  grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} --color=never -Eo '\[.*\]' "${AWS_CONFIG_FILE:-$HOME/.aws/config}" | sed -E 's/^[[:space:]]*\[(profile)?[[:space:]]*([-_[:alnum:]\.@]+)\][[:space:]]*$/\2/g'
}

asp () {
  if [[ -z "$1" ]]
  then
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE
    echo AWS profile cleared.
    return
  fi

  export AWS_DEFAULT_PROFILE=$1
  export AWS_PROFILE=$1
  export AWS_EB_PROFILE=$1
}
