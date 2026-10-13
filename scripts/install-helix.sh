#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
make_temp

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

if has hx; then
    echo "==> hx already installed"
else
    install_helix
fi
