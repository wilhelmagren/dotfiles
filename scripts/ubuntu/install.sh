#!/usr/bin/env bash

set -eou pipefail

SCRIPTDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

GITDIR="$HOME/git"
CONFIGDIR="$HOME/.config"

printf "\033[36m"
cat << 'EOF'
         __                __
  __  __/ /_  __  ______  / /___  __
 / / / / __ \/ / / / __ \/ __/ / / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ /
\__,_/_.___/\__,_/_/ /_/\__/\__,_/

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
sudo "$SCRIPTDIR/system-install.sh"

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

fish -c "set -Ux JAVA_HOME /usr/lib/jvm/default-java"

echo -e "\nSetup complete! Please reboot the system and/or restart your shell."
