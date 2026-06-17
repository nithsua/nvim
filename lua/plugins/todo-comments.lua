-- Highlight + navigate TODO/FIXME/HACK/NOTE comments.
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = vim.g.have_nerd_font },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
    { "<leader>st", "<cmd>TodoQuickFix<cr>", desc = "Search todos (quickfix)" },
  },
}
