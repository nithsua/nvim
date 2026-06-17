-- Formatting (runs dedicated formatters; falls back to LSP formatting).
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "x" },
      desc = "Format buffer",
    },
    {
      "<leader>tf",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
      end,
      desc = "Toggle format-on-save",
    },
  },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      go = { "goimports", "gofumpt" },
      lua = { "stylua" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
  init = function()
    -- Use conform for gq and other format operations.
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true -- this buffer only
      else
        vim.g.disable_autoformat = true -- globally
      end
    end, { bang = true, desc = "Disable format-on-save (! = current buffer only)" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable format-on-save" })
  end,
}
