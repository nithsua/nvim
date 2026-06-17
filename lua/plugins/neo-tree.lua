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
  -- Load neo-tree (and let it take over) when nvim is opened on a directory.
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the open file
      use_libuv_file_watcher = true, -- auto-refresh on external changes
      hijack_netrw_behavior = "open_default", -- open as a sidebar (stays open when you open a file)
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
