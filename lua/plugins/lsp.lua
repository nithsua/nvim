-- LSP: mason installs the servers; Neovim 0.11+ native vim.lsp.config/enable
-- configures and turns them on. clangd (C/C++), gopls (Go), lua_ls (this config).
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd", "gopls", "lua_ls" },
        automatic_enable = false, -- we enable explicitly below
      },
    },
  },
  config = function()
    -- Diagnostics UI.
    local nf = vim.g.have_nerd_font
    vim.diagnostic.config({
      severity_sort = true,
      update_in_insert = false,
      underline = { severity = vim.diagnostic.severity.ERROR },
      float = { border = "rounded", source = true },
      virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
      signs = nf and {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = " ",
        },
      } or true,
    })

    -- Per-server settings (merged onto nvim-lspconfig's defaults).
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          analyses = { unusedparams = true, nilness = true, unusedwrite = true, useany = true },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
          diagnostics = { globals = { "vim" } },
          hint = { enable = true },
        },
      },
    })

    -- Turn the servers on (uses cmd from PATH: system clangd/gopls work
    -- immediately; mason's copies take over once installed).
    vim.lsp.enable({ "clangd", "gopls", "lua_ls" })

    -- Buffer-local keymaps + inlay hints when a server attaches.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
      callback = function(ev)
        local buf = ev.buf
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
        end

        map("gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
        map("gr", function() Snacks.picker.lsp_references() end, "References")
        map("gI", function() Snacks.picker.lsp_implementations() end, "Goto implementation")
        map("gy", function() Snacks.picker.lsp_type_definitions() end, "Type definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Document symbols")
        map("K", function() vim.lsp.buf.hover() end, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
        map("<leader>th", function()
          local on = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
          vim.lsp.inlay_hint.enable(not on, { bufnr = buf })
        end, "Toggle inlay hints")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = buf })
        end
      end,
    })
  end,
}
