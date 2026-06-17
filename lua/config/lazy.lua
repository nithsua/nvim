-- Bootstrap lazy.nvim (clones it on first launch).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load every spec file under lua/plugins/.
require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true, notify = false }, -- check for plugin updates quietly
  change_detection = { notify = false },
})
