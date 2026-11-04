#!/usr/bin/env sh
# Install this Neovim config on macOS / Linux.
# Usage: curl -fsSL https://raw.githubusercontent.com/gubgub63/nvim-config/main/install.sh | sh
set -eu

REPO="https://github.com/gubgub63/nvim-config.git"
TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

command -v git >/dev/null 2>&1 || { echo "git is required" >&2; exit 1; }

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim not found, installing..."
  if command -v brew >/dev/null 2>&1; then brew install neovim
  elif command -v apt-get >/dev/null 2>&1; then sudo apt-get install -y neovim
  elif command -v dnf >/dev/null 2>&1; then sudo dnf install -y neovim
  elif command -v pacman >/dev/null 2>&1; then sudo pacman -S --noconfirm neovim
  else echo "Install Neovim (>= 0.10) manually: https://neovim.io" >&2; exit 1
  fi
fi

if [ -e "$TARGET" ]; then
  BACKUP="$TARGET.bak.$(date +%Y%m%d%H%M%S)"
  echo "Existing config moved to $BACKUP"
  mv "$TARGET" "$BACKUP"
fi

mkdir -p "$(dirname "$TARGET")"
git clone "$REPO" "$TARGET"
echo "Done. Run: nvim (plugins install on first launch)"
