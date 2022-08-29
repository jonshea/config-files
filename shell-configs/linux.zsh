if [ "$(uname)" = "Linux" ]; then
    alias ls='ls -GFah --color'
    alias code='emacs'

    ZSH_COMP_PATH="${CONFIGS_DIR}/zsh-completions/src"
    fpath=("${ZSH_COMP_PATH}" $fpath)

    test -f .asdf/asdf.sh && source $HOME/.asdf/asdf.sh
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
fi
