#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
make_temp

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

install_fzf() {
    if command -v fzf &>/dev/null; then
        echo "fzf already installed: $(fzf --version)"
        return
    fi

    echo "Installing fzf..."

    local version="0.74.5"
    local arch
    arch="$(uname -m)"

    case "$arch" in
        x86_64)  arch="amd64" ;;
        aarch64) arch="arm64" ;;
        *)
            echo "Unsupported architecture: $arch"
            return 1
            ;;
    esac

    local tmp_dir
    tmp_dir="$(mktemp -d)"

    curl -fsSL \
        "https://github.com/junegunn/fzf/releases/download/v${version}/fzf-${version}-linux_${arch}.tar.gz" \
        -o "$tmp_dir/fzf.tar.gz" || {
            rm -rf "$tmp_dir"
            return 1
        }

    tar -xzf "$tmp_dir/fzf.tar.gz" -C "$tmp_dir" || {
        rm -rf "$tmp_dir"
        return 1
    }

    mkdir -p "$HOME/.local/bin"
    install -m 755 "$tmp_dir/fzf" "$HOME/.local/bin/fzf"

    rm -rf "$tmp_dir"

    echo "fzf installed successfully."
}

if has rg; then echo '==> ripgrep already installed'; else install_ripgrep; fi
if has fd; then echo '==> fd already installed'; else install_fd; fi
if has fzf; then echo '==> fzf already installed'; else install_fzf; fi
