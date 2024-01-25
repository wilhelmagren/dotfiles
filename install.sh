#!/bin/bash
exec 3>&1

RESET='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'

CWD_PATH=$(pwd)
TMP_PATH="/tmp/dotfiles"
FONTS_PATH="$HOME/.local/share/fonts"

TMP_PATH_ALACRITTY="${TMP_PATH}/alacritty"
CFG_SRC_PATH_ALACRITTY="${CWD_PATH}/.config/alacritty"
CFG_TARGET_PATH_ALACRITTY="${HOME}/.config"

TMP_PATH_NEOVIM="${TMP_PATH}/neovim"
CFG_SRC_PATH_NEOVIM="${CWD_PATH}/.config/nvim"
CFG_TARGET_PATH_NEOVIM="${HOME}/.config"

CFG_SRC_PATH_STARSHIP="${CWD_PATH}/.config/starship.toml"
CFG_TARGET_PATH_STARSHIP="${HOME}/.config/starship.toml"

TMP_PATH_GOLANG="${TMP_PATH}/go"

function repeat_character ()
{
    for i in $( seq 0 $2 ); do printf "$1"; done
}

function banner ()
{
    msglen=$(( ${#1} + 2 ))
    nchars=$(( ($(tput cols) - msglen + (msglen % 2)) / 2 ))
    repeat_character "${GREEN}=" $(( nchars ))
    printf "$1"
    repeat_character "=" $(( $(tput cols) - msglen - nchars ))
    printf "${RESET}\n"
}

function query_user()
{
    printf "$1\n"
    while true; do
        read -p "Are you sure that you want to proceed with doing this? [y\\n]" yn
        case $yn in
            [Yy]* ) log_info "you chose 'yes', starting installation process..."; break;;
            [Nn]* ) log_info "you chose 'no', exiting..."; exit;;
            * ) printf "Please answer either yes or no.\n";;
        esac
    done
}

function log_info ()
{
    printf "[$(date --utc)] [${GREEN}INFO${RESET}]  $1\n" 1>&3
}

function log_warning ()
{
    printf "[$(date --utc)] [${YELLOW}WARNING${RESET}]  $1\n" 1>&3
}

#
# Ask user for verification to install a bunch of stuff.
#
clear
banner " gabagool SYSTEM INSTALLER "
query_user "THIS SCRIPT WILL INSTALL AND BUILD A BUNCH OF STUFF AS ROOT"

#
# Update package manager and set up sudo access if not had previously.
#
log_info "setting up 'sudo' and updating package manager..."
mkdir -p $TMP_PATH
sudo apt-get update
log_info "OK!"

#
# Install common build utils.
#
log_info "installing common build tools & utilities..."
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 ninja-build gettext unzip curl
log_info "OK!"

#
# Install the Rust compiler and Cargo tools.
#
log_info "installing Rust compiler, please follow any on screen prompts..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
log_info "OK!"

#
# Build and install Alacritty from source.
#
log_info "installing 'alacritty'..."
git clone https://github.com/alacritty/alacritty.git $TMP_PATH_ALACRITTY
cd $TMP_PATH_ALACRITTY

cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd $CWD_PATH
log_info "OK!"

log_info "setting up 'alacritty' config..."
mkdir -p $CFG_TARGET_PATH_ALACRITTY
cp -r $CFG_SRC_PATH_ALACRITTY $CFG_TARGET_PATH_ALACRITTY
log_info "OK!"

#
# Build and install Neovim from source.
#
log_info "installing 'neovim'..."
git clone https://github.com/neovim/neovim $TMP_PATH_NEOVIM
cd $TMP_PATH_NEOVIM
log_info "checking out 'stable' version..."
git checkout stable

log_info "setting up dependencies..."
sudo apt-get install ninja-build gettext cmake unzip curl

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd $CWD_PATH
log_info "OK!"

log_info "setting up 'neovim' config..."
mkdir -p $CFG_TARGET_PATH_NEOVIM
cp -r $CFG_SRC_PATH_NEOVIM $CFG_TARGET_PATH_NEOVIM
log_info "OK!"

#
# Build and install starship prompt.
#
log_info "installing 'starship' from crates.io ..."
cargo install starship --locked

log_info "setting up 'starship' config..."
cp $CFG_SRC_PATH_STARSHIP $CFG_TARGET_PATH_STARSHIP
log_info "OK!"

#
# Install golang.
#
log_info "installing 'golang' from go.dev archive..."
cd $TMP_PATH_GOLANG
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
cd $CWD_PATH
log_info "OK!"

log_info "setting up path to Go binary, and testing version..."
export PATH=$PATH:/usr/local/go/bin
go version
log_info "OK!"

#
# Install jdk and jre.
# Yea, Java..., needed for some stuffs.
#
log_info "installing 'default-jre' and 'default-jdk'..."
sudo apt-get install default-jre
sudo apt-get install default-jdk
log_info "OK!"

#
# Install nodejs and npm.
# Yes, npm... but it is needed for some nvim language servers.
#
log_info "installing 'nodejs' and 'npm'..."
sudo apt-get install nodejs
sudo apt-get install npm
log_info "OK!"

#
# Install some Python deps.
#
log_info "installing some Python3 deps and utilities..."
sudo apt-get install python3-venv
python3 -m pip install --upgrade pip
python3 -m pip install notebook
log_info "OK!"

#
# Install tmux plugin manager (tpm).
#
log_info "installing 'tmux' and 'tmux plugin manager (tpm)'..."
sudo apt-get install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
log_info "OK!"

#
# Move some dotfiles to home folder.
#
log_info "installing common dotfiles to your $HOME folder..."
cp $CWD_PATH/.bashrc $HOME
cp $CWD_PATH/.bash_aliases $HOME
cp $CWD_PATH/.tmux.conf $HOME
log_info "OK!"

#
# Install a Nerd Font for icons etc.
#
log_info "installing 'FiraMono Nerd Font'..."
cd $TMP_PATH
if [ ! -d "$FONTS_PATH" ]; then
    log_warning "you did not have a $FONTS_PATH on your system, creating it for you..."
    mkdir -p $FONTS_PATH
fi
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip
unzip FiraMono.zip -d $FONTS_PATH
log_info "OK!"

#
# Cleaning up tmp folders.
#
log_info "cleaning up any tmp folders created..."
rm go1.21.6.linux-amd64.tar.gz
rm -rf TMP_PATH_ALACRITTY
rm -rf TMP_PATH_NEOVIM
rm -rf TMP_PATH_GOLANG
log_info "OK!"

banner " DONE! "
