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
        RG_ARCH="aarch64-unknown-linux-gnu"
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

# ------------------------------------------------------------
# Neovim
# ------------------------------------------------------------

echo "==> Installing Neovim"

curl -fsSL \
    "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" \
    -o "$TMP_DIR/nvim.tar.gz"

rm -rf "$APP_DIR/nvim"
mkdir -p "$APP_DIR/nvim"

tar -xzf "$TMP_DIR/nvim.tar.gz" \
    --strip-components=1 \
    -C "$APP_DIR/nvim"

ln -sf "$APP_DIR/nvim/bin/nvim" "$BIN_DIR/nvim"

# ------------------------------------------------------------
# ripgrep
# ------------------------------------------------------------

echo "==> Installing ripgrep"

RG_URL="$(
    curl -fsSL \
        https://api.github.com/repos/BurntSushi/ripgrep/releases/latest |
    grep '"browser_download_url":' |
    grep "${RG_ARCH}.tar.gz\"" |
    cut -d '"' -f 4 |
    head -n 1
)"

if [ -z "$RG_URL" ]; then
    echo "Could not find ripgrep release for $ARCH"
    exit 1
fi

curl -fsSL "$RG_URL" \
    -o "$TMP_DIR/rg.tar.gz"

mkdir -p "$TMP_DIR/rg"

tar -xzf "$TMP_DIR/rg.tar.gz" \
    -C "$TMP_DIR/rg"

find "$TMP_DIR/rg" \
    -type f \
    -name rg \
    -exec cp {} "$BIN_DIR/rg" \;

chmod +x "$BIN_DIR/rg"

# ------------------------------------------------------------
# fd
# ------------------------------------------------------------

echo "==> Installing fd"

FD_URL="$(
    curl -fsSL \
        https://api.github.com/repos/sharkdp/fd/releases/latest |
    grep '"browser_download_url":' |
    grep "${FD_ARCH}.tar.gz\"" |
    cut -d '"' -f 4 |
    head -n 1
)"

if [ -z "$FD_URL" ]; then
    echo "Could not find fd release for $ARCH"
    exit 1
fi

curl -fsSL "$FD_URL" \
    -o "$TMP_DIR/fd.tar.gz"

mkdir -p "$TMP_DIR/fd"

tar -xzf "$TMP_DIR/fd.tar.gz" \
    -C "$TMP_DIR/fd"

find "$TMP_DIR/fd" \
    -type f \
    -name fd \
    -exec cp {} "$BIN_DIR/fd" \;

chmod +x "$BIN_DIR/fd"

# ------------------------------------------------------------
# Tree-sitter CLI
# ------------------------------------------------------------

echo "==> Installing Tree-sitter CLI"

TS_URL="$(
    curl -fsSL \
        https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest |
    grep '"browser_download_url":' |
    grep "tree-sitter-linux-${TS_ARCH}.zip\"" |
    cut -d '"' -f 4 |
    head -n 1
)"

if [ -z "$TS_URL" ]; then
    echo "Could not find Tree-sitter release for $ARCH"
    exit 1
fi

curl -fsSL "$TS_URL" \
    -o "$TMP_DIR/tree-sitter.zip"

mkdir -p "$TMP_DIR/tree-sitter"

if command -v unzip >/dev/null 2>&1; then
    unzip -q \
        "$TMP_DIR/tree-sitter.zip" \
        -d "$TMP_DIR/tree-sitter"
else
    echo "ERROR: unzip is required to install Tree-sitter."
    exit 1
fi

find "$TMP_DIR/tree-sitter" \
    -type f \
    -name tree-sitter \
    -exec cp {} "$BIN_DIR/tree-sitter" \;

chmod +x "$BIN_DIR/tree-sitter"

# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------

export PATH="$BIN_DIR:$PATH"

# ------------------------------------------------------------
# Verify
# ------------------------------------------------------------

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
echo "Add this to ~/.zshrc if it isn't already there:"
echo
echo 'export PATH="$HOME/.local/bin:$PATH"'
