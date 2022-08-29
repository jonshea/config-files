if (( $+commands[asdf] )); then
    test_and_source ~/.asdf/plugins/java/set-java-home.zsh
else
    MISSING_APPS+=('asdf')
fi
