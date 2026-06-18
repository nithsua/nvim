-- Auto-install non-LSP CLI tools (formatters/linters) via mason.
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    -- Note: clang-format is installed via Homebrew, not mason — mason's pypi
    -- clang-format package is broken upstream ("no supported Python versions").
    ensure_installed = {
      "gofumpt", -- Go (stricter gofmt; used as golines' base formatter)
      "goimports", -- Go (imports)
      "golines", -- Go (wrap long lines to a max width)
      "stylua", -- Lua
    },
    run_on_start = true,
  },
}
