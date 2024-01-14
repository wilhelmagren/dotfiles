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

CWDPATH=$(pwd)
TMPPATH="/tmp/dotfiles"
ALACRITTYPATH="${TMPPATH}/alacritty"

function repeat_character ()
{
    for i in $( seq 0 $2 ); do printf "$1"; done
}

function banner ()
{
    msglen=$(( ${#1} + 2 ))
    nchars=$(( ($(tput cols) - msglen + (msglen % 2)) / 2 ))
    repeat_character "${PURPLE}=" $(( nchars ))
    printf "$1"
    repeat_character "=" $(( $(tput cols) - msglen - nchars ))
    printf "${RESET}\n"
}

function query_user()
{
    printf "THIS SCRIPT WILL INSTALL AND BUILD A BUNCH OF STUFF AS ROOT\n"
    while true; do
        read -p "Are you sure that you want to proceed with doing this? [y\\n]" yn
        case $yn in
            [Yy]* ) log_info "you chose ``yes``, starting installation process..."; break;;
            [Nn]* ) log_info "you chose ``no``, exiting..."; exit;;
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
banner " DEBIAN SYSTEM SETUP "
query_user

#
# Update package manager and set up sudo access if not had previously.
#
log_info "setting up ``sudo`` and updating package manager..."
mkdir -p $TMPPATH
sudo apt-get update
log_info "OK!"

#
# Install the Rust compiler and Cargo tools.
#
log_info "installing Rust compiler, please follow any on screen prompts..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
log_info "OK!"

#
# Build and install Alacritty from source.
#
log_info "installing ``alacritty``..."
git clone https://github.com/alacritty/alacritty.git $ALACRITTYPATH
cd $ALACRITTYPATH

log_info "setting up dependencies..."
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd $CWDPATH
log_info "OK!"

log_info "setting up ``alacritty`` config..."

log_info "OK!"

