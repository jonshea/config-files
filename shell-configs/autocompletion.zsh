PACKAGE_PATH=~/.zsh-packages

function test_and_source {
    test -f "$1" && source "$1"
}

# https://github.com/zsh-users/zsh-autosuggestions
test_and_source $PACKAGE_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh

# substring-search and zsh-syntax-highlighting are disabled beacuse
# they break `select-word-style bash` (in particular, they cause M-<delete>)
# to not stop at  `/` or `-`.

# https://github.com/zsh-users/zsh-history-substring-search
test_and_source $PACKAGE_PATH/zsh-history-substring-search/zsh-history-substring-search.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
# TODO This plugin wants to be `source`ed last. If you do not source it last
# then it definitely breaks `select-word-style bash` (in particular, they cause M-<delete>)
# to not stop at  `/` or `-`.
test_and_source $PACKAGE_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
