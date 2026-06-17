-- Popup that shows available keybindings as you type a prefix.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      -- Group labels for our <leader> prefixes (filled in by later stages).
      { "<leader>b", group = "buffer" },
      { "<leader>d", group = "diagnostics" },
      { "<leader>f", group = "find/format" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer-local keymaps",
    },
  },
}
