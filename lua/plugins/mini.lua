-- Small focused editing helpers from the mini.nvim family.
return {
  -- Auto-insert matching brackets/quotes.
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Add/delete/replace surroundings (gsa"  gsd"  gsr"( ).
  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "gsd", desc = "Delete surrounding" },
      { "gsr", desc = "Replace surrounding" },
    },
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    },
  },
}
