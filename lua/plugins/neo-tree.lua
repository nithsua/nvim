-- File explorer (sidebar tree with git status + diagnostics).
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal<cr>", desc = "Explorer (neo-tree)" },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the open file
      use_libuv_file_watcher = true, -- auto-refresh on external changes
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        hide_dotfiles = false, -- show dotfiles (handy for config editing)
        hide_gitignored = false,
      },
    },
    window = {
      width = 32,
      mappings = {
        ["<space>"] = "none", -- keep <space> as leader inside the tree
      },
    },
  },
}
