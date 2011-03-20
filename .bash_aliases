alias ls="ls -Ah -F -G"
## --group-directories-first --color=auto"

alias solr="java -Dsolr.solr.home=solr -jar start.jar"
alias ec="emacsclient -n"
alias py=python

alias less="less -R"
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias idl='/Applications/rsi/idl/bin/idl'
alias emacs="emacs -nw"
alias hosts="sudo emacs /etc/hosts; dscacheutil -flushcache"
alias ipaddr="ifconfig en1 | awk '$2~/[0-9]+\./{print$2}'"
alias grep="grep -E --color=auto"

(which rlwrap > /dev/null) && alias ocaml="rlwrap ocaml"

alias new_password="apg -t -a 0 -M sNcl -n 6 -x 10 -m 8 -s"

alias backup_research="rsync -avz /Users/jonshea/research/ jonshea.strongspace.com\:/home/jonshea/backup/research"

# Csh compatability:
#
alias unsetenv=unset
function setenv () {
  export $1="$2"
}
