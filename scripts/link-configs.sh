#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

link_config() {
    local source="$1" target="$2" backup
    mkdir -p "$(dirname "$target")"
    if [ -L "$target" ]; then
        if [ "$(readlink "$target")" = "$source" ]; then
            echo "==> Config already linked: $target"
            return
        fi
        rm -- "$target"
    elif [ -e "$target" ]; then
        backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
        while [ -e "$backup" ] || [ -L "$backup" ]; do backup="${backup}.1"; done
        echo "==> Backing up $target to $backup"
        mv -- "$target" "$backup"
    fi
    ln -s -- "$source" "$target"
    echo "==> Linked $target -> $source"
}

for editor in helix nvim; do
    if [ -d "$DOTFILES_DIR/$editor" ]; then
        link_config "$DOTFILES_DIR/$editor" "$HOME/.config/$editor"
    else
        echo "WARNING: $DOTFILES_DIR/$editor not found; skipping"
    fi
done
