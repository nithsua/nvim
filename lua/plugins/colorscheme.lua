-- Colorscheme. Swap this file out for any other theme later.
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before everything else so the UI doesn't flash
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte / frappe / macchiato / mocha
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        gitsigns = true,
        mini = { enabled = true },
        which_key = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
