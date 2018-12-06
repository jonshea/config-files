export PATH=~/bin:/usr/local/sbin:/usr/local/bin:$PATH
export JAVA_HOME=$(test -f /usr/libexec/java_home && /usr/libexec/java_home)

export PYTHONSTARTUP=/Users/jonshea/.pythonstartup.py
export PYTHONDONTWRITEBYTECODE=1

export GOPATH="$HOME/code/go"
export PATH=$PATH:$GOPATH/bin

export IGNOREEOF=1  # pressing Ctrl+D once will not exit Bash

## Open X11 for graphics (must be running already)
export DISPLAY=:0.0

export HISTSIZE=
export HISTFILESIZE=
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTCONTROL=erasedups	# causes all previous lines matching the current line to be removed from the history list before that line is saved

export PAGER=less;
## export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export EDITOR=emacsclient
export ALTERNATE_EDITOR='emacs'

shopt -s cdspell # Fix mispellings for cd command
shopt -s histappend  # Append to, rather than overwite, to history on disk
PROMPT_COMMAND='history -a' # Write the history to disk whenever you display the prompt

export LC_CTYPE=en_US.UTF-8

function test_and_source {
##    (test -f "${1}" && source "${1}") || echo "Could not source: ${1}"
    test -f "${1}" && source "${1}"
}

export CONFIGS_DIR=~/config-files

## RVM_PATH=/usr/local/rvm
## test_and_source $RVM_PATH/rvm/scripts/rvm

## Aliases in seperate file
test_and_source $CONFIGS_DIR/.bash_aliases

# Bash completion is the best
export BASH_COMPLETION=$(brew --prefix)/etc/bash_completion
export BASH_COMPLETION_DIR=/usr/local/etc/bash_completion.d
test_and_source $BASH_COMPLETION
test_and_source $CONFIGS_DIR/ruby-completion/completion-ruby-all

# ec2 support
test_and_source .ec2/.ec2rc

function gr {
    ## If the current working directory is inside of a git repository,
    ## this function will change it to the git root (ie, the directory
    ## that contains the .git/ directory), and then print the new directory.
    git branch > /dev/null 2>&1 || return 1

    cd "$(git rev-parse --show-cdup)".
    pwd
}

function ff {
    ## Find file
    ## find . -name "${1}" 2> /dev/null
    mdfind -name "${1}"
}

export PS1='\h:\W$(__git_ps1 " (%s)")\$ '

## I do not know where this next line came from.
##export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

export PATH="$HOME/.cargo/bin:$PATH"
