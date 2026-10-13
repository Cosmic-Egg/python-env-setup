#!/usr/bin/env bash
set -euo pipefail

# Shared settings and helpers. Source from scripts in this directory.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
BIN_DIR="$HOME/.local/bin"
OPT_DIR="$HOME/.local/opt"
DOTFILES_DIR="$REPO_DIR/.dotfiles"
mkdir -p "$BIN_DIR" "$OPT_DIR"
export PATH="$BIN_DIR:$HOME/.cargo/bin:$PATH"
ARCH="$(uname -m)"
case "$ARCH" in
    x86_64) NVIM_ARCH=x86_64; RG_ARCH=x86_64-unknown-linux-musl; FD_ARCH=x86_64-unknown-linux-musl ;;
    aarch64|arm64) NVIM_ARCH=arm64; RG_ARCH=aarch64-unknown-linux-gnu; FD_ARCH=aarch64-unknown-linux-musl ;;
    *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac
has() { command -v "$1" >/dev/null 2>&1; }
latest_tag() {
    curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$1/releases/latest" | sed 's#.*/##'
}
# Each install script owns its temporary directory; cleanup on exit.
make_temp() {
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR"' EXIT
}
