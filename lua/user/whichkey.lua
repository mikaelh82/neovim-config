local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    v = { "<cmd>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "LSP" },
    o = { name = "Obsidian" },
    p = { name = "Plugins" },
    ["<TAB>"] = {
      name = "Tabby",
      n = { "<CMD>tabnew<CR>", "New Empty Tab" },
      f = { "<CMD>tabnext<CR>", "Tab Forward" },
      b = { "<CMD>tabprevious<CR>", "Tab Backward" },
      c = { "<CMD>tabclose<CR>", "Close Tab" },
      m = { "<CMD>tabmove +1<CR>", "Move current tab to next position" },
      M = { "<CMD>tabmove -1<CR>", "Move current tab to previous position" },
      a = { "<CMD>1gt<CR>", "Go to first tab" },
      z = { "<CMD>tablast<CR>", "Go to last tab" },
    },
    ["W"] = {
      name = "Window",
      t = { "<C-w>p", "Toogle window" },
      d = { "<C-w>c", "Delete window" },
      r = { "<C-w>v", "Split window right" },
      b = { "<C-w>s", "Split window below" },

    },
    T = { name = "Treesitter" },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
