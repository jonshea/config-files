# https://github.com/junegunn/fzf
# https://www.freecodecamp.org/news/fzf-a-command-line-fuzzy-finder-missing-demo-a7de312403ff/
if (( $+commands[fzf] )); then
    # This line intentionally left blank
elif test -f ~/.fzf.zsh; then
    source ~/.fzf.zsh
fi

# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
test -f "/usr/local/opt/fzf/shell/key-bindings.zsh" && source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Set up ripgrep?
# https://github.com/junegunn/fzf#respecting-gitignore
# https://dev.to/matrixersp/how-to-use-fzf-with-ripgrep-to-selectively-ignore-vcs-files-4e27
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# alias ff='rg --files --hidden --follow | fzf'
alias ff=fzf
alias ffp='fzf --preview "head -100 {}"'

# TODO: Make an alias for fzf history search. Apparently c-R does this.
# TODO: Tab completion? https://medium.com/@herryhan2435/using-aws-cli-with-fzf-on-ohmyzsh-ec995ee3784f
