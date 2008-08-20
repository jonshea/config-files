alias ls="ls -ah -F -G"
## --group-directories-first --color=auto"

alias py=python

alias less="less -R"
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias idl='/Applications/rsi/idl/bin/idl'
alias emacs="emacs -nw"
alias hosts="sudo emacs /etc/hosts; dscacheutil -flushcache"

alias backup_research="rsync -avz /Users/jonshea/research/ jonshea.strongspace.com\:/home/jonshea/backup/research"

# Csh compatability:
#
alias unsetenv=unset
function setenv () {
  export $1="$2"
}
