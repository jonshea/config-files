# Notes:
# https://htr3n.github.io/2018/07/faster-zsh/
#
#
export CONFIGS_DIR=~/config-files

function test_and_source {
    test -f "$1" && source "$1"
}

## Source platform specific code
test_and_source "${CONFIGS_DIR}/.zshrc.$(uname)"
test_and_source "${CONFIGS_DIR}/.zshrc.$(hostname)"
test_and_source "${CONFIGS_DIR}/.zshrc.private"

export JAVA_HOME=$(test -f /usr/libexec/java_home && /usr/libexec/java_home -v 1.8)

export EDITOR=emacs
export VISUAL=emacs

export IGNOREEOF=1  # pressing Ctrl+D once should not exit the shell

export LC_CTYPE=en_US.UTF-8 # Without this, arrow keys in emacs over ssh don’t work. Shrug.

# fpath=(/usr/local/share/zsh-completions $fpath)
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
# HISTORY_IGNORE="(select-window|select-pane|set -t)"
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

setopt AUTO_CD # treat `some/dir/here` as `cd some/dir/here`

alias grep="grep -E --color=auto"
alias emcas="emacs"

export RIPGREP_CONFIG_PATH=~/.ripgreprc

if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=rg
  export TAG_CMD_FMT_STRING="code --goto {{.Filename}}:{{.LineNumber}}:{{.ColumnNumber}}"
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias rg=tag  # replace with rg for ripgrep
fi

function gr {
    ## If the current working directory is inside of a git repository,
    ## this function will change it to the git root (ie, the directory
    ## that contains the .git/ directory), and then print the new directory.
    git branch > /dev/null 2>&1 || return 1

    cd "$(git rev-parse --show-cdup)".
    pwd
}

function find_time_machine_exclusions {
    mdfind "com_apple_backup_excludeItem = com.apple.backupd"
}

# Switch current Java version
function jdk() {
    if (( $# == 0 )); then
        # If no version given, then list available Java versions
        echo "Available Java versions:"
        /usr/libexec/java_home -V
    else
        echo "Switching to Java ${1}"
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v "$version");
        java -version
    fi
}

# https://github.com/junegunn/fzf
# https://www.freecodecamp.org/news/fzf-a-command-line-fuzzy-finder-missing-demo-a7de312403ff/
test_and_source "${CONFIGS_DIR}/.zshrc.fzf"

# Bash promput was:
# PS1='\h:\W$(__git_ps1 " (%s)")\$ '
# jonshea:~(main)$
# hostname:top_level_dir(git_branch)$
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh


if test -f /usr/local/etc/bash_completion.d/git-prompt.sh; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
fi

test_and_source "${CONFIGS_DIR}/.zshrc.placed"
