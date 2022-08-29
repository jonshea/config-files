if (( $+commands[starship] )); then
  # eval "$(starship init zsh)"
else
    MISSING_APPS+=('starship')
fi
