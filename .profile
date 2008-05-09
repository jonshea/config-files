export PATH=/usr/local/sbin:/usr/local/bin:~/bin:$PATH
# export GIT_EXTERNAL_DIFF=git-external-chdiff

## MacPorts
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"

export IGNOREEOF=1  # pressing Ctrl+D once will not exit Bash

## Open X11 for graphics (must be running already)
export DISPLAY=:0.0

export HISTIGNORE="&:ls:ls *:[bf]g:exit"
export HISTCONTROL=erasedups	# causes all previous lines matching the current line to be removed from the history list before that line is saved

export PAGER=less;
export EDITOR='/Applications/Aquamacs\ Emacs.app/Contents/MacOS/bin/emacsclient'
export ALTERNATE_EDITOR='emacs'

export IDL_PATH="<IDL_DEFAULT>:~/research:~/research/libraries:~/research/libraries/astrolib:~/research/libraries/db:~/research/libraries/plotting:~/research/libraries/textoidl:~/research/libraries/JHUAPL:~/research/libraries/cmlib:~/research/libraries/buie:~/research/libraries/coyoteprograms"

shopt -s cdspell # Fix mispellings for cd command
shopt -s histappend  # Append to, rather than overwite, to history on disk
PROMPT_COMMAND='history -a' # Write the history to disk whenever you display the prompt

export LC_CTYPE=en_US.UTF-8

## Aliases in seperate file
test -f ~/.bash_aliases && . ~/.bash_aliases

# Bash completion is the best
test -f /opt/local/etc/bash_completion && . /opt/local/etc/bash_completion

# ec2 support
test -f .ec2/.ec2rc && . .ec2/.ec2rc

## export PS1='\h:\W$(__git_ps1 " ")\$ '