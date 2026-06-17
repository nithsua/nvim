-- Leader keys must be set before plugins load (lazy.nvim).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core editor configuration.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin manager + plugin specs (lua/plugins/*).
require("config.lazy")
