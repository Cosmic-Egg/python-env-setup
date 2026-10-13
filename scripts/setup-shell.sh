#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"

add_line() {
    local file="$1" line="$2"
    touch "$file"
    if ! grep -qxF "$line" "$file"; then
        printf '\n%s\n' "$line" >> "$file"
        echo "==> Updated $file"
    fi
}

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    # Preserve the original behavior: update zshrc only when it already exists.
    if [ "$rc" = "$HOME/.bashrc" ] || [ -f "$rc" ]; then
        add_line "$rc" 'export PATH="$HOME/.local/bin:$PATH"'
    fi
done
add_line "$HOME/.bashrc" 'export COLORTERM=truecolor'
add_line "$HOME/.bashrc" 'if command -v fzf >/dev/null 2>&1; then eval "$(fzf --bash)"; fi'
