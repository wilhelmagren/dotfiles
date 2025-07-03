#!/usr/bin/env bash

set -eou pipefail

sudo apt-get install ninja-build gettext cmake curl build-essential

git clone https://github.com/neovim/neovim & cd neovim
git checkout tags/$1
make CMAKE_BUILD_TYPE=RelWIthDebInfo
printf "\nDone building neovim (nvim)\n";

sudo make install

printf "\nDone installing nvim to '$(which nvim)'\n";

printf "\nCleaning up cloned repo... ";
cd ..
rm -rf neovim
printf "OK\n";

###########################################################
#             Manually install nvim-treesitter.           #
###########################################################

cd ~/.config/nvim
mkdir pack && cd pack
mkdir nvim-treesitter && cd nvim-treesitter
mkdir start && cd start
git clone https://github.com/nvim-treesitter/nvim-treesitter.git && cd nvim-treesitter
git checkout tags/v0.10.0

printf "\nDone installing nvim-treesitter plugin!\n";

