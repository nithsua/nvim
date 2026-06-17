-- Editor options. See `:h option-list` for everything available.
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (4-space, expand tabs)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- case-sensitive only if the pattern has uppercase
opt.hlsearch = true
opt.incsearch = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes" -- always show, avoids text shifting
opt.cursorline = true
opt.scrolloff = 8 -- keep lines of context above/below cursor
opt.sidescrolloff = 8
opt.wrap = false
opt.colorcolumn = "100"
opt.showmode = false -- statusline already shows the mode

-- Splits open in a natural direction
opt.splitright = true
opt.splitbelow = true

-- Files / behavior
opt.swapfile = false
opt.backup = false
opt.undofile = true -- persistent undo across sessions
opt.updatetime = 250 -- faster CursorHold + diagnostics
opt.timeoutlen = 400 -- time to complete a mapped sequence
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- use the system clipboard

-- Show whitespace
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
