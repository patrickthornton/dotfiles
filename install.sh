#!/usr/bin/env bash
#
# install.sh — bootstrap this dotfiles repo on a new macOS machine.
#
# Idempotent: safe to re-run. Existing real files/dirs at a target are moved
# aside to "<target>.backup.<timestamp>" before the symlink is created; existing
# symlinks are replaced in place.
#
# Usage:
#   ./install.sh            # create all symlinks
#   ./install.sh --brew     # also install Homebrew + run the Brewfile
#   ./install.sh --dry-run  # print what would happen, change nothing

set -euo pipefail

# Resolve the repo dir (the dir this script lives in), even if called via symlink.
SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE"
done
DOTFILES="$(cd -P "$(dirname "$SOURCE")" && pwd)"

DRY_RUN=false
DO_BREW=false
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    --brew)    DO_BREW=true ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

run() { # echo + execute (or just echo in dry-run)
  if $DRY_RUN; then echo "  would: $*"; else eval "$@"; fi
}

link() { # link <repo-relative-src> <absolute-dst>
  local src="$DOTFILES/$1"
  local dst="$2"
  if [ ! -e "$src" ]; then
    echo "skip (missing in repo): $1"
    return
  fi
  run "mkdir -p \"$(dirname "$dst")\""
  if [ -L "$dst" ]; then
    run "rm \"$dst\""                       # stale/old symlink — replace
  elif [ -e "$dst" ]; then
    local backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
    echo "  backing up existing $dst"
    run "mv \"$dst\" \"$backup\""
  fi
  run "ln -s \"$src\" \"$dst\""
  echo "  linked $dst -> $src"
}

CONFIG="$HOME/.config"
APPSUP="$HOME/Library/Application Support"

echo "dotfiles: $DOTFILES"
$DRY_RUN && echo "(dry run — no changes will be made)"
echo

echo "==> ~/.config directory configs"
link alacritty "$CONFIG/alacritty"
link aerospace "$CONFIG/aerospace"
link borders   "$CONFIG/borders"
link fish      "$CONFIG/fish"
link ghostty   "$CONFIG/ghostty"
link helix     "$CONFIG/helix"
link zellij    "$CONFIG/zellij"

echo "==> single-file configs"
link starship/starship.toml "$CONFIG/starship.toml"
link zed/settings.json      "$CONFIG/zed/settings.json"  # leaves zed's prompts/ db + themes/ untouched

echo "==> home-level dotfiles"
link gdb/.gdbinit "$HOME/.gdbinit"
link hushlogin    "$HOME/.hushlogin"                     # silences the macOS "Last login" message

echo "==> ~/Library/Application Support configs"
link lazygit "$APPSUP/lazygit"
link nushell "$APPSUP/nushell"

echo
echo "symlinks done."

if $DO_BREW; then
  echo
  echo "==> Homebrew"
  if ! command -v brew >/dev/null 2>&1; then
    run "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    # make brew available for the rest of this run (Apple Silicon path)
    if [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
  fi
  echo "==> brew bundle (Brewfile)"
  run "brew bundle --file=\"$DOTFILES/Brewfile\""
fi

echo
echo "all done. open a new terminal to pick up changes."
echo "note: 'pyright/pyrightconfig.json' is a per-project file and is intentionally not linked."
