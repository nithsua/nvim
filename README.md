# Neovim config

A hand-rolled, modular Neovim configuration focused on **C/C++** and **Go**.
Monokai Pro (pro filter) on a pure-black background, [lazy.nvim](https://github.com/folke/lazy.nvim)
for plugin management, and Neovim's native LSP.

## Quick start (fresh Mac)

One idempotent script installs everything (Homebrew, Neovim, Ghostty, the
toolchain + fonts), clones this config, sets a `vi`/`vim` → `nvim` alias, and
installs the plugins. Safe to re-run.

```sh
curl -fsSL https://raw.githubusercontent.com/nithsua/nvim/main/bootstrap.sh -o /tmp/nvim-bootstrap.sh
bash /tmp/nvim-bootstrap.sh
```

Then open a new terminal (Ghostty) and run `vi`. On the first launch mason
finishes installing the LSP servers and Treesitter parsers compile — give it a
moment, then restart. See [`bootstrap.sh`](bootstrap.sh) for exactly what it does.

## Requirements

- Neovim **0.11+** (uses the native `vim.lsp.config`/`vim.lsp.enable` API)
- `git`, a C compiler (for Treesitter parsers), `go`
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) + [`fd`](https://github.com/sharkdp/fd) (fuzzy finding)
- `clang-format` (`brew install clang-format`) — C/C++ formatting
- A terminal with **true color** + a **Nerd Font** (or built-in symbol fallback,
  e.g. Ghostty). Icons auto-disable in Terminal.app via `vim.g.have_nerd_font`.

LSP servers (`clangd`, `gopls`, `lua_ls`) and the Go/Lua formatters
(`gofumpt`, `goimports`, `stylua`) are installed automatically by
[mason](https://github.com/mason-org/mason.nvim) on first launch.

## Structure

```
init.lua                 leader keys, nerd-font flag, PATH, load order
lua/config/
  options.lua            editor options
  keymaps.lua            general keymaps
  autocmds.lua           autocommands
  lazy.lua               plugin-manager bootstrap
lua/plugins/             one file per plugin (auto-imported)
  colorscheme.lua        monokai-pro on #000000
  lualine.lua  which-key.lua
  neo-tree.lua  snacks.lua        explorer + fuzzy finder
  treesitter.lua
  lsp.lua  blink.lua  mason-tools.lua  conform.lua
  gitsigns.lua  mini.lua  todo-comments.lua
```

## Key mappings

Leader is `<Space>`. Press `<leader>` and wait — which-key shows what's available.

| Key | Action |
| --- | --- |
| `<leader>e` | File explorer (neo-tree) |
| `<leader>ff` / `fg` / `fb` / `fr` | find files / grep / buffers / recent |
| `<leader><space>` | smart file finder |
| `gd` `gr` `gI` `gy` | definition / references / impls / type def |
| `K` / `<leader>rn` / `<leader>ca` | hover / rename / code action |
| `<leader>ss` | document symbols |
| `<leader>th` | toggle inlay hints |
| `[d` / `]d` | prev / next diagnostic |
| `<leader>cf` | format buffer |
| `<leader>tf` | toggle format-on-save |
| `]h` / `[h` | next / prev git hunk |
| `<leader>gs` / `gr` / `gp` / `gb` | stage / reset / preview hunk · blame |
| `gsa` / `gsd` / `gsr` | add / delete / replace surround |
| `]t` / `[t` | next / prev TODO comment |
| `<S-h>` / `<S-l>` | prev / next buffer |
| `<C-h/j/k/l>` | move between windows |

## Managing it

- `:Lazy` — plugins (install/update/clean)
- `:Mason` — LSP servers & tools
- `:checkhealth` — diagnose issues

## Notes

- **Theme/font**: change the colorscheme in `lua/plugins/colorscheme.lua`.
  The font is set by your terminal, not Neovim.
- **Format-on-save** is on by default; `:FormatDisable` / `:FormatEnable` or
  `<leader>tf` to toggle.
- **Debugging (nvim-dap)** is intentionally not set up yet — planned as a later
  addition.
