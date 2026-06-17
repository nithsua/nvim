-- Leader keys must be set before plugins load (lazy.nvim).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Whether the terminal can render Nerd Font icon glyphs. Auto-off in
-- Terminal.app (no glyph fallback + no true color); on elsewhere. Plugins
-- read this to choose icons vs plain-text. Flip manually if a terminal differs.
vim.g.have_nerd_font = vim.env.TERM_PROGRAM ~= "Apple_Terminal"

-- Make mason-installed tools (formatters, linters) findable on PATH at startup,
-- before mason itself loads — so conform can locate clang-format/stylua/etc.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- Disable netrw — neo-tree is the file explorer. Must be set before plugins load.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Core editor configuration.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin manager + plugin specs (lua/plugins/*).
require("config.lazy")
