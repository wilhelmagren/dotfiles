#!/usr/bin/env bash

set -eou pipefail

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root (via sudo)."
    exit 1
fi

sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu

sudo apt update
sudo apt upgrade

sudo apt install -y \
    build-essential git curl wget ripgrep fzf jq htop tmux cmake ninja-build openjdk-21-jdk \
    maven gradle stow zoxide tree openjdk-17-jdk eza ghostty
