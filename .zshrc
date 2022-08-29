# location: ~/.zshrc
#
# Notes:
# https://htr3n.github.io/2018/07/faster-zsh/
#
#
# zmodload zsh/zprof # Begin startup profiling
export CONFIGS_DIR=~/config-files

function test_and_source {
    test -f "$1" && source "$1"
}

## Source platform specific code
test_and_source "${CONFIGS_DIR}/secrets/secrets.zsh"

for f in $CONFIGS_DIR/shell-configs/*.zsh; do
   source $f
done

export EDITOR=emacs
export VISUAL=emacs

export IGNOREEOF=1  # pressing Ctrl+D once should not exit the shell because I fat finger it too often

export LC_CTYPE=en_US.UTF-8 # Without this, arrow keys in emacs over ssh don’t work. Shrug.
export GPG_TTY=$(tty)

autoload -Uz compinit && compinit -u
# brew installed zsh git completions are in /usr/local/share/zsh/site-functions, but zsh-completions seems to take care of it anyway.

autoload -U select-word-style
select-word-style bash

## History search
export HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# HISTORY_IGNORE="(select-window|select-pane|set -t|cd ..)"
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt INC_APPEND_HISTORY        # Append to history file immediately after each command
setopt AUTO_CD # treat `some/dir/here` as `cd some/dir/here`

alias grep="grep -E --color=auto"
alias emcas="emacs"

# Prompt is disabled to give starship and autocomplete a try.
if test -f /usr/local/etc/bash_completion.d/git-prompt.sh; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
fi

test_and_source "${CONFIGS_DIR}/.zshrc.placed"

# zprof # End profiling

# Import stuff that needs to happen last
test_and_source "${CONFIGS_DIR}/shell-configs/autocompletion.zsh"
