# .bash_profile

# Split bashrc into smaller, more specific files
source ~/.shell/aliases.sh
source ~/.shell/exports.sh
source ~/.shell/functions.sh
source ~/.shell/sources.sh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
