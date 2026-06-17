-- Leader keys must be set before plugins load (lazy.nvim).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Whether the terminal can render Nerd Font icon glyphs. Auto-off in
-- Terminal.app (no glyph fallback + no true color); on elsewhere. Plugins
-- read this to choose icons vs plain-text. Flip manually if a terminal differs.
vim.g.have_nerd_font = vim.env.TERM_PROGRAM ~= "Apple_Terminal"

-- Core editor configuration.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin manager + plugin specs (lua/plugins/*).
require("config.lazy")
