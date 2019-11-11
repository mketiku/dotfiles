# quick navigation
#############
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#color search
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

#list items in a directory
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lt='ls -lart'

# serve this directory
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias pymg="python manage.py"
alias pymgrn="python manage.py runserver"
# clean out pyc files from current directory
alias pycclean='find . -name "*.pyc" -exec rm {} \; && find . -name "__pycache__" -exec rm -rf {} \;'

# Disk free in human terms
alias dfh='df -h'
alias dir='dir --color=auto'

# Get system memory, cpu usage and gpu memory quickly
## pass options to free ##
alias meminfo='free -m -l -t'
## Get server cpu info ##
alias cpuinfo='lscpu'

# default output for ps
alias pso="ps auxf"

# Become system administrator
alias god='sudo -i'

# Add safety nets
## do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

## confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

## Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

#############
#Network
alias ping1='ping -c 4 www.google.com'
alias ping2='ping -c 4 192.168.0.1'
alias wget='wget -c'
#Get your public IP address and host.
alias getipinfo1="hostname -I && curl ifconfig.me"
alias getipinfo2="hostname -I && curl http://icanhazip.com"
##Show open ports Use netstat command to quickly list all TCP/UDP port on the server:
alias ports='netstat -tulanp'
alias port='netstat -nlp'
alias sports='sudo netstat -tulanp'
alias sport='sudo netstat -nlp'
#show which applications are connecting to the network
alias listen="lsof -P -i -n"
#############

#############
# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# makes free more hunan readable
alias free="free -mt"
alias cls='clear'

# search history
alias histg="history | grep"
alias h='history'

# continue wget download in case of problems
alias wget="wget -c"

# install programs in ubuntu lazy style
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias apt-install='sudo apt-get install'

# look busy and technical
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
