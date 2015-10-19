alias ls="ls -Ah -F -G"
## --group-directories-first --color=auto"

alias scala="scala -Dfile.encoding=UTF-8 -deprecation"
kill_sbt() { "pkill -l "$@" sbt" }

alias sbt="/Users/jonshea/projects/sbt-extras/sbt"

alias less="less -R"
alias grep="grep -E --color=auto"

(which rlwrap > /dev/null) && alias ocaml="rlwrap ocaml"

alias new_password="apg -t -a 0 -M sNcl -n 6 -x 10 -m 8 -s"

alias oiddate="python -c \"import struct;import sys;import datetime;print(datetime.datetime.ytcfromtimestamp(struct.unpack('>i', sys.argv[1].decode('hex')[0:4])[0]))\""
alias makeoid="python -c \"import sys; import struct; import calendar; import dateutil.parser; print (struct.pack('>i', int(calendar.timegm(dateutil.parser.parse(' '.join(sys.argv[1:])).timetuple()))) +  '\x00' * 8).encode('hex')\""
