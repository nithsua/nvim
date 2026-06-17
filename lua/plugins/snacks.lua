-- snacks.nvim — using its picker (fuzzy finder) module.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep (live)" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor", mode = { "n", "x" } },
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
  },
}
