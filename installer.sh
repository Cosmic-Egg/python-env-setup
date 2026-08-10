```bash
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

# ------------------------------------------------------------
# Helper: get latest GitHub release tag
# ------------------------------------------------------------

latest_tag() {
    curl -fsSLI \
        -o /dev/null \
        -w '%{url_effective}' \
        "https://github.com/$1/releases/latest" |
    sed 's#.*/##'
}

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

RG_TAG="$(latest_tag BurntSushi/ripgrep)"
RG_VERSION="${RG_TAG#v}"

echo "    Latest version: $RG_VERSION"

curl -fsSL \
    "https://github.com/BurntSushi/ripgrep/releases/download/${RG_TAG}/ripgrep-${RG_VERSION}-${RG_ARCH}.tar.gz" \
    -o "$TMP_DIR/rg.tar.gz"

mkdir -p "$TMP_DIR/rg"

tar -xzf "$TMP_DIR/rg.tar.gz" \
    -C "$TMP_DIR/rg"

cp \
    "$TMP_DIR/rg/ripgrep-${RG_VERSION}-${RG_ARCH}/rg" \
    "$BIN_DIR/rg"

chmod +x "$BIN_DIR/rg"

# ------------------------------------------------------------
# fd
# ------------------------------------------------------------

echo "==> Installing fd"

FD_TAG="$(latest_tag sharkdp/fd)"
FD_VERSION="${FD_TAG#v}"

echo "    Latest version: $FD_VERSION"

curl -fsSL \
    "https://github.com/sharkdp/fd/releases/download/${FD_TAG}/fd-v${FD_VERSION}-${FD_ARCH}.tar.gz" \
    -o "$TMP_DIR/fd.tar.gz"

mkdir -p "$TMP_DIR/fd"

tar -xzf "$TMP_DIR/fd.tar.gz" \
    -C "$TMP_DIR/fd"

cp \
    "$TMP_DIR/fd/fd-v${FD_VERSION}-${FD_ARCH}/fd" \
    "$BIN_DIR/fd"

chmod +x "$BIN_DIR/fd"

# ------------------------------------------------------------
# Tree-sitter CLI
# ------------------------------------------------------------

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
echo 'Make sure this is in ~/.zshrc:'
echo
echo 'export PATH="$HOME/.local/bin:$PATH"'
```

