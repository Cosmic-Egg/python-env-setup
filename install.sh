#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    echo "Usage: $0 [all|editors|tools|configs|shell]"
}

editors() {
    bash "$ROOT/scripts/install-neovim.sh"
    bash "$ROOT/scripts/install-helix.sh"
}
tools() {
    bash "$ROOT/scripts/install-cli-tools.sh"
    bash "$ROOT/scripts/install-python-tools.sh"
}
configs() { bash "$ROOT/scripts/link-configs.sh"; }
shell_setup() { bash "$ROOT/scripts/setup-shell.sh"; }

case "${1:-all}" in
    all) editors; tools; configs; shell_setup ;;
    editors) editors ;;
    tools) tools ;;
    configs) configs ;;
    shell) shell_setup ;;
    -h|--help) usage ;;
    *) usage >&2; exit 2 ;;
esac

echo "==> Done. Open a new shell to pick up shell configuration changes."
