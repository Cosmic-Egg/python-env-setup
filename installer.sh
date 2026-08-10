#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share"
TMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$BIN_DIR" "$APP_DIR"

ARCH="$(uname -m)"

case "$ARCH" in
    x86_64)
        NVIM_ARCH="x86_64"
        RG_ARCH="x86_64-unknown-linux-musl"
        FD_ARCH="x86_64-unknown-linux-gnu"
        TS_ARCH="x64"
        ;;
    aarch64|arm64)
        NVIM_ARCH="arm64"
        RG_ARCH="aarch64-unknown-linux-musl"
        FD_ARCH="aarch64-unknown-linux-gnu"
        TS_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Detected architecture: $ARCH"
echo

latest_tag() {
    curl -fsSLI \
        -o /dev/null \
        -w '%{url_effective}' \
        "https://github.com/$1/releases/latest" |
        sed 's#.*/##'
}

install_neovim() {
    echo "==> Installing Neovim"

    case "$ARCH" in
        x86_64)
            NVIM_COMPAT_ARCH="x86_64"
            ;;
        aarch64|arm64)
            NVIM_COMPAT_ARCH="arm64"
            ;;
    esac

    curl -fsSL \
        "https://github.com/neovim/neovim-releases/releases/latest/download/nvim-linux-${NVIM_COMPAT_ARCH}.tar.gz" \
        -o "$TMP_DIR/nvim.tar.gz"

    rm -rf "$APP_DIR/nvim"
    mkdir -p "$APP_DIR/nvim"

    tar -xzf "$TMP_DIR/nvim.tar.gz" \
        --strip-components=1 \
        -C "$APP_DIR/nvim"

    ln -sf "$APP_DIR/nvim/bin/nvim" "$BIN_DIR/nvim"
}

install_ripgrep() {
    echo "==> Installing ripgrep"

    local tag
    local version

    tag="$(latest_tag BurntSushi/ripgrep)"
    version="${tag#v}"

    echo "    Version: $version"

    curl -fsSL \
        "https://github.com/BurntSushi/ripgrep/releases/download/${tag}/ripgrep-${version}-${RG_ARCH}.tar.gz" \
        -o "$TMP_DIR/rg.tar.gz"

    mkdir -p "$TMP_DIR/rg"

    tar -xzf "$TMP_DIR/rg.tar.gz" \
        -C "$TMP_DIR/rg"

    cp \
        "$TMP_DIR/rg/ripgrep-${version}-${RG_ARCH}/rg" \
        "$BIN_DIR/rg"

    chmod +x "$BIN_DIR/rg"
}

install_fd() {
    echo "==> Installing fd"

    local tag
    local version

    tag="$(latest_tag sharkdp/fd)"
    version="${tag#v}"

    echo "    Version: $version"

    curl -fsSL \
        "https://github.com/sharkdp/fd/releases/download/${tag}/fd-v${version}-${FD_ARCH}.tar.gz" \
        -o "$TMP_DIR/fd.tar.gz"

    mkdir -p "$TMP_DIR/fd"

    tar -xzf "$TMP_DIR/fd.tar.gz" \
        -C "$TMP_DIR/fd"

    cp \
        "$TMP_DIR/fd/fd-v${version}-${FD_ARCH}/fd" \
        "$BIN_DIR/fd"

    chmod +x "$BIN_DIR/fd"
}

install_tree_sitter() {
    echo "==> Installing Tree-sitter CLI"

    curl -fsSL \
        "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-${TS_ARCH}.zip" \
        -o "$TMP_DIR/tree-sitter.zip"

    mkdir -p "$TMP_DIR/tree-sitter"

    unzip -q \
        "$TMP_DIR/tree-sitter.zip" \
        -d "$TMP_DIR/tree-sitter"

    cp \
        "$TMP_DIR/tree-sitter/tree-sitter" \
        "$BIN_DIR/tree-sitter"

    chmod +x "$BIN_DIR/tree-sitter"
}

install_neovim
install_ripgrep
install_fd
# install_tree_sitter

export PATH="$BIN_DIR:$PATH"

echo
echo "========================================"
echo "Installed successfully"
echo "========================================"
echo

nvim --version | head -n 1
rg --version | head -n 1
fd --version
tree-sitter --version

echo
echo 'Add this to ~/.zshrc if needed:'
echo
echo 'export PATH="$HOME/.local/bin:$PATH"'
