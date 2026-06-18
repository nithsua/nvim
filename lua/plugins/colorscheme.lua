-- Colorscheme: kanagawa (wave) forced onto a pure-black background.
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000, -- load before everything else so the UI doesn't flash
  opts = {
    theme = "wave", -- wave / dragon / lotus
    background = { dark = "wave" },
    -- Black out the main backgrounds; overrides deep-merge, so kanagawa's
    -- foreground palette (and cursorline/visual contrast) is preserved.
    overrides = function()
      local black = "#000000"
      return {
        Normal = { bg = black },
        NormalNC = { bg = black },
        NormalFloat = { bg = black },
        FloatBorder = { bg = black },
        FloatTitle = { bg = black },
        SignColumn = { bg = black },
        LineNr = { bg = black },
        Folded = { bg = black },
        NormalSB = { bg = black },
        Pmenu = { bg = black },
        StatusLine = { bg = black },
        StatusLineNC = { bg = black },
      }
    end,
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}
