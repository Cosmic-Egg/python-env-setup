#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
make_temp

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

if has uv; then echo '==> uv already installed'; else install_uv; fi
if has ruff; then echo '==> Ruff already installed'; else install_ruff; fi
if has ty; then echo '==> ty already installed'; else install_ty; fi
