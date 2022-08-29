if (( $+commands[exa] )); then
  alias ls='exa -a --color=auto'
else
  MISSING_APPS+=('exa')
fi
