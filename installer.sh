#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Directories
# ------------------------------------------------------------

BIN_DIR="$HOME/.local/bin"
OPT_DIR="$HOME/.local/opt"
TMP_DIR="$(mktemp -d)"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/.dotfiles"
HELIX_CONFIG="$HOME/.config/helix"
NVIM_CONFIG="$HOME/.config/nvim"

trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$BIN_DIR" "$OPT_DIR"

# Make locally installed binaries available to this script.
export PATH="$BIN_DIR:$PATH"

# ------------------------------------------------------------
# Architecture
# ------------------------------------------------------------

ARCH="$(uname -m)"

case "$ARCH" in
    x86_64)
        NVIM_ARCH="x86_64"
        RG_ARCH="x86_64-unknown-linux-musl"
        FD_ARCH="x86_64-unknown-linux-musl"
        ;;

    aarch64|arm64)
        NVIM_ARCH="arm64"
        RG_ARCH="aarch64-unknown-linux-gnu"
        FD_ARCH="aarch64-unknown-linux-musl"
        ;;

    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Detected architecture: $ARCH"
echo

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

has() {
    command -v "$1" >/dev/null 2>&1
}

latest_tag() {
    curl -fsSLI \
        -o /dev/null \
        -w '%{url_effective}' \
        "https://github.com/$1/releases/latest" |
        sed 's#.*/##'
}

add_to_path() {
    local path_line='export PATH="$HOME/.local/bin:$PATH"'

    for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$rc" ]; then
            if ! grep -qxF "$path_line" "$rc"; then
                echo >> "$rc"
                echo "$path_line" >> "$rc"
                echo "Added ~/.local/bin to $rc"
            fi
        fi
    done

    export PATH="$BIN_DIR:$PATH"
}

# ------------------------------------------------------------
# Helix
# ------------------------------------------------------------
install_helix() {
    echo "==> Installing Helix"

    local tag
    local version
    local helix_arch

    tag="$(latest_tag helix-editor/helix)"
    version="${tag#v}"

    case "$ARCH" in
        x86_64)
            helix_arch="x86_64-linux"
            ;;
        aarch64|arm64)
            helix_arch="aarch64-linux"
            ;;
        *)
            echo "ERROR: Unsupported architecture for Helix: $ARCH"
            exit 1
            ;;
    esac

    echo "    Version: $version"

    curl -fsSL \
        "https://github.com/helix-editor/helix/releases/download/${tag}/helix-${version}-${helix_arch}.tar.xz" \
        -o "$TMP_DIR/helix.tar.xz"

    mkdir -p "$TMP_DIR/helix"

    tar -xJf "$TMP_DIR/helix.tar.xz" \
        -C "$TMP_DIR/helix"

    local helix_dir
    helix_dir="$(find "$TMP_DIR/helix" -mindepth 1 -maxdepth 1 -type d -print -quit)"

    if [ -z "$helix_dir" ] || [ ! -x "$helix_dir/hx" ]; then
        echo "ERROR: hx binary was not found in downloaded archive."
        exit 1
    fi

    rm -rf "$OPT_DIR/helix"
    mv "$helix_dir" "$OPT_DIR/helix"

    ln -sfn "$OPT_DIR/helix/hx" "$BIN_DIR/hx"

    echo "    Installed."
}

link_config() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [ -L "$target" ]; then
        if [ "$(readlink "$target")" = "$source" ]; then
            echo "==> Config already linked: $target"
            return
        fi

        echo "==> Replacing existing symlink: $target"
        rm "$target"
    elif [ -e "$target" ]; then
        echo "==> Existing config found: $target"
        echo "    Moving it to: ${target}.backup"
        mv "$target" "${target}.backup"
    fi

    ln -s "$source" "$target"

    echo "==> Linked $target"
    echo "    -> $source"
}

# ------------------------------------------------------------
# Neovim
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# ripgrep
# ------------------------------------------------------------

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

    local rg_binary
    rg_binary="$(find "$TMP_DIR/rg" -type f -name rg -print -quit)"

    if [ -z "$rg_binary" ]; then
        echo "ERROR: rg binary was not found in downloaded archive."
        exit 1
    fi

    cp "$rg_binary" "$BIN_DIR/rg"
    chmod +x "$BIN_DIR/rg"

    echo "    Installed."
}

# ------------------------------------------------------------
# fd
# ------------------------------------------------------------

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

    local fd_binary
    fd_binary="$(find "$TMP_DIR/fd" -type f -name fd -print -quit)"

    if [ -z "$fd_binary" ]; then
        echo "ERROR: fd binary was not found in downloaded archive."
        exit 1
    fi

    cp "$fd_binary" "$BIN_DIR/fd"
    chmod +x "$BIN_DIR/fd"

    echo "    Installed."
}
install_nvim_config() {
    echo "==> Installing Neovim configuration"

    local config_dir="$HOME/.config/nvim"

    if [ -d "$config_dir/.git" ]; then
        echo "    Already installed."
        return
    fi

    mkdir -p "$HOME/.config"

    git clone \
        https://github.com/Cosmic-Egg/nvim_dotfiles.git \
        "$config_dir"

    echo "    Installed."
}

install_uv() {
    echo "==> Installing uv"

    curl -LsSf https://astral.sh/uv/install.sh \
        -o "$TMP_DIR/uv-install.sh"

    sh "$TMP_DIR/uv-install.sh"

    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    echo "    Installed."
}

install_ruff() {
    echo "==> Installing Ruff"

    uv tool install ruff@latest

    echo "    Installed."
}

install_ty() {
    echo "==> Installing ty"

    uv tool install ty@latest

    echo "    Installed."
}

# ------------------------------------------------------------
# Install
# ------------------------------------------------------------

if has nvim; then
    echo "==> Neovim already installed"
else
    install_neovim
fi

# install_nvim_config

if has rg; then
    echo "==> ripgrep already installed"
else
    install_ripgrep
fi

if has fd; then
    echo "==> fd already installed"
else
    install_fd
fi

if has uv; then
    echo "==> uv already installed"
else
    install_uv
	export PATH="$HOME/.local/bin:$PATH"
fi

if has ruff; then
    echo "==> Ruff already installed"
else
    install_ruff
fi

if has ty; then
    echo "==> ty already installed"
else
    install_ty
fi

if has hx; then
    echo "==> Helix already installed"
else
    install_helix
fi

# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------
if [ -d "$DOTFILES_DIR/helix" ]; then
    link_config "$DOTFILES_DIR/helix" "$HELIX_CONFIG"
else
    echo "WARNING: Helix dotfiles not found:"
    echo "    $DOTFILES_DIR/helix"
fi

if [ -d "$DOTFILES_DIR/nvim" ]; then
    link_config "$DOTFILES_DIR/nvim" "$NVIM_CONFIG"
else
    echo "WARNING: Neovim dotfiles not found:"
    echo "    $DOTFILES_DIR/nvim"
fi

add_to_path


# ------------------------------------------------------------
# Bashrc
# ------------------------------------------------------------
configure_truecolor() {
    echo "==> Configuring true color support"

    local line='export COLORTERM=truecolor'

    if ! grep -qxF "$line" "$HOME/.bashrc"; then
        echo "$line" >> "$HOME/.bashrc"
        echo "    Added COLORTERM=truecolor to ~/.bashrc"
    else
        echo "    Already configured."
    fi

    export COLORTERM=truecolor
}
configure_truecolor


# ------------------------------------------------------------
# Verification
# ------------------------------------------------------------

echo
echo "========================================"
echo "Installation complete"
echo "========================================"
echo

if [ -x "$BIN_DIR/nvim" ]; then
    "$BIN_DIR/nvim" --version | head -n 1
else
    nvim --version | head -n 1
fi

if [ -x "$BIN_DIR/rg" ]; then
    "$BIN_DIR/rg" --version | head -n 1
else
    rg --version | head -n 1
fi

if [ -x "$BIN_DIR/fd" ]; then
    "$BIN_DIR/fd" --version
else
    fd --version
fi

echo
echo "Installed binaries are available from:"
echo "  $BIN_DIR"
echo
echo "If this was your first install, open a new shell or run:"
echo
echo '  source ~/.bashrc'
