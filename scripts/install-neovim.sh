#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
make_temp

install_neovim() {
    echo "==> Installing Neovim"

    local install_dir="$OPT_DIR/nvim"

    curl -fsSL \
        "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" \
        -o "$TMP_DIR/nvim.tar.gz"

    rm -rf "$install_dir"
    mkdir -p "$install_dir"

    tar -xzf "$TMP_DIR/nvim.tar.gz" \
        --strip-components=1 \
        -C "$install_dir"

    ln -sfn "$install_dir/bin/nvim" "$BIN_DIR/nvim"

    echo "    Installed."
}

if has nvim; then
    echo "==> nvim already installed"
else
    install_neovim
fi
