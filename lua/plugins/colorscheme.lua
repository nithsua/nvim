-- Colorscheme: tokyonight (night) forced onto a pure-black background.
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- load before everything else so the UI doesn't flash
  opts = {
    style = "night", -- darkest variant; matches the palette you picked
    on_colors = function(colors)
      -- Pure black everywhere, keep tokyonight's syntax palette.
      local black = "#000000"
      colors.bg = black
      colors.bg_dark = black
      colors.bg_float = black
      colors.bg_popup = black
      colors.bg_sidebar = black
      colors.bg_statusline = black
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
