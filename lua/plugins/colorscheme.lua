-- Colorscheme: Monokai Pro forced onto a pure-black background.
return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000, -- load before everything else so the UI doesn't flash
  config = function()
    require("monokai-pro").setup({
      filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    })

    -- Keep Monokai Pro's syntax colors but force the background to true black.
    local bg = "#000000"
    local bg_groups = {
      "Normal", "NormalNC", "NormalFloat", "FloatBorder",
      "SignColumn", "EndOfBuffer", "FoldColumn", "LineNr",
      "CursorLineNr", "MsgArea", "WinSeparator",
    }
    local function blacken()
      for _, name in ipairs(bg_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        hl.bg = bg
        vim.api.nvim_set_hl(0, name, hl)
      end
    end

    vim.api.nvim_create_autocmd("ColorScheme", { callback = blacken })
    vim.cmd.colorscheme("monokai-pro")
    blacken()
  end,
}
