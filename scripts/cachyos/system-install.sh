#!/usr/bin/env bash

set -eou pipefail

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root (via sudo)."
    exit 1
fi

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
    base-devel git curl wget ripgrep fzf jq htop tmux cmake ninja jdk21-openjdk \
    maven gradle sbt go ghostty lua-language-server stow tree-sitter tree-sitter-cli \
    zoxide tree jdk17-openjdk
 
sudo pacman -S --needed --noconfirm \
    cachyos-gaming-meta cachyos-hooks gamemode mangohud mesa vulkan-radeon \
    lib32-vulkan-radeon steam protonplus discord
