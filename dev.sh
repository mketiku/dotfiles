#!/bin/bash
# Created with influence from:
#   - https://github.com/junegunn/fzf/blob/master/install
#   - https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
# Run pihole install separately then copy and paste in setupVars.conf to etc/pihole dir


# Usage: bash dev.sh or curl -sSl https://raw.githubusercontent.com/mketiku/dotfiles/master/dev.sh | bash

#unalias cp = cp -i to allow overwrites
if alias cp 2>/dev//null;
then 
    unalias cp
fi

ask() {
    while true; do
        read -p "$1 ([y]/n) " -r
        REPLY=${REPLY:-"y"}
        if [[ $REPLY =~ ^[Yy]$ ]]; then return 1
        elif [[ $REPLY =~ ^[Nn]$ ]]; then return 0
        fi
    done
}

is_command() {
    # Checks for existence of string passed in as only function argument.
    # Exit value of 0 when exists, 1 if not exists. Value is the result
    # of the `command` shell built-in call.
    local check_command="$1"
    command -v "${check_command}" >/dev/null 2>&1
}

help() {
  cat << EOF
usage: $0 [OPTIONS]
    --help               Show this message
    --all                Install awesome vim, fzf, oh my zsh and npm
EOF
}

install_awesome_vim=
install_fzf=
install_oh_my_zsh=
install_npm=
install_pihole=
install_plex=

for opt in "$@"; do
    case $opt in
        --help)
            help
            exit 0
        ;;
        --all)
            install_awesome_vim=1
            install_fzf=1
            install_oh_my_zsh=1
            install_npm=1
            install_pihole=1
            install_plex=1
        ;;
        --simple)
            install_awesome_vim=1
            install_fzf=1
            install_oh_my_zsh=1
        ;;
        *)
            echo "unknown option: $opt"
            help
            exit 1
        ;;
    esac
done

if [ -z "$install_awesome_vim" ]; then
    ask "Do you want to install awesome vim?"
    install_awesome_vim=$?
fi

if [ -z "$install_fzf" ]; then
    ask "Do you want to install fzf?"
    install_fzf=$?
fi

if [ -z "$install_oh_my_zsh" ]; then
    ask "Do you want to install oh my zsh?"
    install_oh_my_zsh=$?
fi

if [ -z "$install_npm" ]; then
    ask "Do you want to install npm?"
    install_npm=$?
fi

if [ -z "$install_pihole" ]; then
    ask "Do you want to install pihole?"
    install_pihole=$?
fi

if [ -z "$install_plex" ]; then
    ask "Do you want to install plex?"
    install_plex=$?
fi

echo "Setting up development environment"

# sudo requires you to retype user password after 10 minutes
# so we try to perform all admin tasks as early as possible

APT_PACKAGES="build-essential curl fonts-powerline fail2ban git gparted python3-dev python3-pip meld ncdu wget whois ufw vim vlc zsh"
PYTHON_PACKAGES="black cookiecutter django flake8 flask httpie pylint requests youtube-dl virtualenvwrapper"

sudo apt-get -y install ${APT_PACKAGES}
if is_command pip3;
then
    yes | sudo pip3 install ${PYTHON_PACKAGES}
fi

# folders
mkdir -p ~/.shell
mkdir -p ~/Projects
mkdir -p ~/.config/Code/User

if ! [ -d ~/Projects/dotfiles ];
then
    git clone https://github.com/mketiku/dotfiles.git ~/Projects/dotfiles
fi

cp ~/Projects/dotfiles/git/.gitconfig ~/.gitconfig
cp ~/Projects/dotfiles/.shell/.nanorc ~/.nanorc
cp ~/Projects/dotfiles/ide/settings_linux.json $HOME/.config/Code/User/settings.json

if [ -f ~/.bash_profile ];
then
    BACKUP_BASH_PROFILE="$(~/.bash_profile)-$(date +%Y-%m-%d_%H-%M-%S)"
    mv ~/.bash_profile "${BACKUP_BASH_PROFILE}"
    cp ~/Projects/dotfiles/.shell/.bash_profile ~/.bash_profile
fi

# shell preferences
cp ~/Projects/dotfiles/.shell/aliases.sh ~/.shell/
cp ~/Projects/dotfiles/.shell/exports.sh ~/.shell/
cp ~/Projects/dotfiles/.shell/functions.sh ~/.shell/
cp ~/Projects/dotfiles/.shell/sources.sh ~/.shell/

# awesome vim
if [ $install_awesome_vim -eq 1 ];
then
    if ! [ -d ~/.vim_runtime/ ] && is_command vim ;
    then 
        git clone git://github.com/amix/vimrc.git ~/.vim_runtime
        sh ~/.vim_runtime/install_awesome_vimrc.sh
    fi
fi

# fzf
if [ $install_fzf -eq 1 ];
then
    if ! [ -d ~/.fzf/ ];
    then 
        yes | sudo apt-get install fzf
    fi
fi

# npm
if [ $install_npm -eq 1 ];
then
    if ! [ -d ~/.config/nvm ];
    then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    fi
    if is_command nvm;
    then
        if ! is_command node;
        then 
            yes | nvm install node
        fi
        if is_command npm;
        then
            yes | npm install -g express webpack eslint
            
        fi
    fi
fi

# oh my zsh
if [ $install_oh_my_zsh -eq 1 ];
then
    if ! [ -d ~/.oh-my-zsh ];
    then 
        yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
                
        BACKUP_ZSHRC="$(~/.zshrc)-$(date +%Y-%m-%d_%H-%M-%S)"
        mv ~/.zshrc "${BACKUP_ZSHRC}"
        cp ~/Projects/dotfiles/.shell/.zshrc ~/.zshrc
    fi
fi

# # pihole
# if [ $install_pihole -eq 1 ];
# # wlan0 interface ; 
# then
#     if ! [ -d /etc/.pihole ];
#     then 
#         sudo curl -sSL https://install.pi-hole.net | bash
#     fi
# fi

# plex
# https://www.how2shout.com/how-to/install-plex-media-server-ubuntu-step-step.html
# if [ $install_plex -eq 1 ];
# then
#
#    if ! is_command plexmediaserver ;
#    then 
#        curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
#        echo deb https://downloads.plex.tv/repo/deb ./public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
#        sudo apt install apt-transport-https -y
#        sudo apt update -y 
#        sudo apt install plexmediaserver -y
#
#    fi
# fi
# or bash -c "$(wget -qO - https://raw.githubusercontent.com/mrworf/plexupdate/master/extras/installer.sh)"


# prompt for a reboot
echo ""
echo "===================="
echo " TIME FOR A REBOOT! "
echo "===================="
echo ""
