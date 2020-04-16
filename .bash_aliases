echo "This is .bash_aliases"

alias ls="ls -Ah -F -G"
## --group-directories-first --color=auto"

alias scala="scala -Dfile.encoding=UTF-8 -deprecation"

alias emcas="emacs"
alias less="less -R"
alias grep="grep -E --color=auto"
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
(which rlwrap > /dev/null) && alias ocaml="rlwrap ocaml"

alias new_password="apg -t -a 0 -M sNcl -n 6 -x 10 -m 8 -s"
