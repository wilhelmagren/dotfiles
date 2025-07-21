#!/usr/bin/env bash

set -eou pipefail

NVIM_PACK_DIR="~/.config/nvim/pack"
mkdir -p "$NVIM_PACK_DIR"

mkdir -p "$NVIM_PACK_DIR/nvim-treesitter/start"
git clone https://github.com/nvim-treesitter/nvim-treesitter.git "$NVIM_PACK_DIR/nvim-treesitter/start/"
pushd "$NVIM_PACK_DIR/nvim-treesitter/start/nvim-treesitter"
git checkout tags/v0.10.0

# mkdir -p "$NVIM_PACK_DIR/plenary.nvim/start"

