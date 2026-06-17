-- Statusline.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto", -- derive colors from the active colorscheme
      icons_enabled = vim.g.have_nerd_font,
      globalstatus = true, -- one statusline for all windows
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_c = { { "filename", path = 1 } }, -- relative path
      lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
    },
  },
}
