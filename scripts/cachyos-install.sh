#!/usr/bin/env bash

set -eou pipefail

SCRIPTDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

GITDIR="$HOME/git"
CONFIGDIR="$HOME/.config"

printf "\033[36m"
cat << 'EOF'

     ______           __          ____  _____
    / ____/___ ______/ /_  __  __/ __ \/ ___/
   / /   / __ `/ ___/ __ \/ / / / / / /\__ \ 
  / /___/ /_/ / /__/ / / / /_/ / /_/ /___/ / 
  \____/\__,_/\___/_/ /_/\__, /\____//____/  
                        /____/
EOF
printf "\033[0m"

function has_prog() {
    if type -p "$1" >/dev/null 2>&1; then
        echo " already installed '$1'"
        return 0
    else
	echo " installing '$1'..."
        return 1
    fi
}

echo -e "\nInstalling system packages..."
sudo "$SCRIPTDIR/cachyos-system-install.sh"

echo -e "\nInstalling user applications..."

if ! has_prog starship; then
    curl -sS https://starship.rs/install.sh | sh
fi

if ! has_prog cargo; then
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
fi

if ! has_prog uv; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    source $HOME/.local/bin/env
fi

has_prog ruff || uv tool install ruff
has_prog ty || uv tool install ty
has_prog pyrefly || uv tool install pyrefly

if ! has_prog nvim; then
    mkdir -p $GITDIR/neovim
    pushd $GITDIR/neovim
    git clone https://www.github.com/neovim/neovim.git
    pushd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    popd
    popd
fi

echo -e "\nSetting up configurations..."

sudo archlinux-java set java-21-openjdk
fish -c "set -Ux JAVA_HOME /usr/lib/jvm/default"

# fish add path will return non-zero exit code if path already exists
mkdir -p $HOME/go/bin
fish -c "fish_add_path ~/go/bin" || true

mkdir -p $HOME/dotfiles
pushd $HOME/dotfiles
mkdir -p fish/.config/fish
mkdir -p nvim/.config/nvim
mkdir -p ghostty/.config/ghostty
popd

echo -e "\nSetup complete! Please reboot the system and/or restart your shell."
