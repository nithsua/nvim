#!/usr/bin/env bash
#
# Idempotent setup for this Neovim configuration on a fresh macOS machine.
# Safe to run repeatedly. Installs Homebrew + tooling, Ghostty, fonts, clones
# the config, sets a `vi`/`vim` -> nvim alias, and installs plugins.
#
# Usage on a brand-new Mac (download then run, so sudo/CLT prompts keep a TTY):
#   curl -fsSL https://raw.githubusercontent.com/nithsua/nvim/main/bootstrap.sh -o /tmp/nvim-bootstrap.sh
#   bash /tmp/nvim-bootstrap.sh
# Or, if the repo is already cloned:
#   ~/.config/nvim/bootstrap.sh
#
set -euo pipefail

REPO_URL="https://github.com/nithsua/nvim.git"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
GHOSTTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"

# --- logging -----------------------------------------------------------------
info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m  ok\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m  ! \033[0m%s\n' "$*"; }
die()  { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || die "This script is for macOS only."

# --- 1. Xcode Command Line Tools (git, clang, make) --------------------------
if xcode-select -p >/dev/null 2>&1; then
  ok "Xcode Command Line Tools present"
else
  info "Installing Xcode Command Line Tools (a GUI dialog will open)..."
  xcode-select --install || true
  info "Waiting for Command Line Tools to finish installing..."
  tries=0
  until xcode-select -p >/dev/null 2>&1; do
    tries=$((tries + 1))
    [[ $tries -gt 360 ]] && die "Command Line Tools not detected after ~60 min. Run 'xcode-select --install' manually, then re-run this script."
    sleep 10
  done
  ok "Command Line Tools installed"
fi

# --- 2. Homebrew -------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_BIN=/opt/homebrew/bin/brew      # Apple Silicon
elif [[ -x /usr/local/bin/brew ]]; then
  BREW_BIN=/usr/local/bin/brew         # Intel
else
  die "Homebrew install appears to have failed (brew not found)."
fi
if ! BREW_ENV="$("$BREW_BIN" shellenv)"; then
  die "Failed to evaluate 'brew shellenv'."
fi
eval "$BREW_ENV"
ok "Homebrew ready"

# Persist brew on PATH for future shells (idempotent).
SHELLENV_LINE="eval \"\$(${BREW_BIN} shellenv)\""
if ! grep -qsF "$SHELLENV_LINE" "$HOME/.zprofile"; then
  printf '\n%s\n' "$SHELLENV_LINE" >>"$HOME/.zprofile"
  ok "Added brew shellenv to ~/.zprofile"
fi

# --- 3. CLI tools the config needs -------------------------------------------
for f in neovim git go ripgrep fd clang-format; do
  if brew list --formula "$f" >/dev/null 2>&1; then
    ok "$f already installed"
  else
    info "Installing $f..."
    brew install "$f" || die "Failed to install '$f'. Resolve the brew error above and re-run."
  fi
done

# --- 4. Ghostty terminal + fonts ---------------------------------------------
for c in ghostty font-sf-mono font-symbols-only-nerd-font; do
  if brew list --cask "$c" >/dev/null 2>&1; then
    ok "$c already installed"
  else
    info "Installing $c..."
    brew install --cask "$c" || warn "Could not install cask '$c' (skipping)"
  fi
done

# --- 5. Neovim config --------------------------------------------------------
if [[ -L "$NVIM_DIR" ]]; then
  warn "$NVIM_DIR is a symlink (managed dotfiles?) - leaving it untouched."
elif [[ -d "$NVIM_DIR/.git" ]]; then
  if git -C "$NVIM_DIR" remote get-url origin 2>/dev/null | grep -q "nithsua/nvim"; then
    info "Updating existing nvim config..."
    if git -C "$NVIM_DIR" diff --quiet && git -C "$NVIM_DIR" diff --cached --quiet; then
      git -C "$NVIM_DIR" pull --ff-only || warn "Could not fast-forward; leaving as-is."
    else
      warn "Local changes in $NVIM_DIR; skipping pull."
    fi
  else
    warn "$NVIM_DIR is a git repo with a different remote; leaving as-is."
  fi
elif [[ -e "$NVIM_DIR" ]]; then
  BACKUP="${NVIM_DIR}.backup.$(date +%Y%m%d-%H%M%S).$$"
  warn "Existing $NVIM_DIR found - backing up to $BACKUP"
  mv "$NVIM_DIR" "$BACKUP"
  git clone "$REPO_URL" "$NVIM_DIR"
else
  info "Cloning nvim config..."
  git clone "$REPO_URL" "$NVIM_DIR"
fi
ok "Config at $NVIM_DIR"

# --- 6. Ghostty config (don't clobber an existing one) -----------------------
mkdir -p "$GHOSTTY_DIR"
if [[ -f "$GHOSTTY_DIR/config" ]]; then
  ok "Ghostty config already present"
else
  cat >"$GHOSTTY_DIR/config" <<'GHCONF'
theme = Homebrew
background = #000000
foreground = #FFFFFF
font-family = SF Mono
font-size = 16
adjust-cell-height = 10%
cursor-style = underline
GHCONF
  ok "Wrote Ghostty config"
fi

# --- 7. vi/vim alias + default editor (idempotent block in ~/.zshrc) ---------
ZSHRC="$HOME/.zshrc"
if ! grep -qsF "# >>> nvim aliases >>>" "$ZSHRC"; then
  cat >>"$ZSHRC" <<'ZRC'

# >>> nvim aliases >>>
alias vi='nvim'
alias vim='nvim'
export EDITOR='nvim'
export VISUAL='nvim'
# <<< nvim aliases <<<
ZRC
  ok "Added vi/vim aliases + EDITOR to ~/.zshrc"
else
  ok "vi/vim aliases already in ~/.zshrc"
fi

# --- 8. Install plugins ------------------------------------------------------
info "Installing Neovim plugins (lazy.nvim)... first run downloads everything."
nvim --headless "+Lazy! sync" +qa || warn "Plugin sync hit an issue; open nvim and run :Lazy"

cat <<'DONE'

------------------------------------------------------------
 Setup complete.

  * Open a NEW terminal (or run: source ~/.zshrc) so `vi` works.
  * Launch Ghostty, then run:  vi
  * On first launch, mason finishes installing the LSP servers
    (clangd, gopls, lua_ls) and Treesitter parsers compile.
    Give it a moment, then restart nvim.
------------------------------------------------------------
DONE
