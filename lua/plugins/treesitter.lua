-- Treesitter: fast, accurate syntax highlighting + indentation.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSInstall", "TSInstallSync" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "c", "cpp",
      "go", "gomod", "gosum", "gowork",
      "lua", "luadoc",
      "vim", "vimdoc", "query",
      "bash", "json", "jsonc", "yaml", "toml",
      "markdown", "markdown_inline",
      "gitcommit", "gitignore", "diff", "regex",
    },
    auto_install = true, -- install a parser the first time you open its filetype
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        node_decremental = "<bs>",
        scope_incremental = false,
      },
    },
  },
}
