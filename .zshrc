## Notes:
# https://htr3n.github.io/2018/07/faster-zsh/
# 
# 

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export JAVA_HOME=$(test -f /usr/libexec/java_home && /usr/libexec/java_home)

export GOPATH="$HOME/code/go"
export PATH=$PATH:$GOPATH/bin

export EDITOR=emacs
export VISUAL=emacs

export IGNOREEOF=1  # pressing Ctrl+D once should not exit the shell

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit && compinit -u
# brew install zsh git completions are in  /usr/local/share/zsh/site-functions, but zsh-completions seems to take care of it anyway?

## History search
export HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
bindkey '^[[A' up-line-or-search                                                
bindkey '^[[B' down-line-or-search

HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

setopt AUTO_CD # treat `some/dir/here` as `cd some/dir/here`

alias ls='ls -GFah'
alias grep="grep -E --color=auto"
alias emcas="emacs"

function gr {
    ## If the current working directory is inside of a git repository,
    ## this function will change it to the git root (ie, the directory
    ## that contains the .git/ directory), and then print the new directory.
    git branch > /dev/null 2>&1 || return 1

    cd "$(git rev-parse --show-cdup)".
    pwd
}

# export PS1='\h:\W$(__git_ps1 " (%s)")\$ '
