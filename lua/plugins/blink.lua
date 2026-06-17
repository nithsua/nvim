-- Completion engine (fast Rust matcher, batteries included).
return {
  "saghen/blink.cmp",
  version = "1.*", -- release tag → downloads a prebuilt binary (no Rust toolchain needed)
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default", -- C-space open, C-e hide, C-y accept, C-n/C-p select
      -- Match a classic nvim-cmp feel on top of the preset:
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
