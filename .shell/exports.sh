export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# load virtualenvs
if [ -d "$HOME/.virtualenvs" ];
then
    export WORKON_HOME=$HOME/.virtualenvs
fi

export PROJECT_HOME=$HOME/Projects

#history
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:exit*:reset*:clear*"
export EDITOR='nano -w'

# syntax highlight for less
# sudo apt-get install source-highlight
if [ -f "/usr/share/source-highlight/src-hilite-lesspipe.sh" ];
then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    export LESS=' -R -N'
fi
