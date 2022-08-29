if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=rg
  export TAG_CMD_FMT_STRING="code --goto {{.Filename}}:{{.LineNumber}}:{{.ColumnNumber}}"
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias rg=tag  # replace with rg for ripgrep
else
    MISSING_APPS+=('tag')
fi
