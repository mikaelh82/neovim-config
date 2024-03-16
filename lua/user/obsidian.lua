local M ={
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
}

  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>oo"] = { "<cmd>ObsidianOpen<cr>", "Open note" },
    ["<leader>on"] = { "<cmd>ObsidianNew<cr>", "New note" },
    ["<leader>oq"] = { "<cmd>ObsidianQuickSwitch<cr>", "Quick switch" },
    ["<leader>of"] = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
    ["<leader>or"] = { "<cmd>ObsidianBacklinks<cr>", "Refs to current buffer" },
    ["<leader>ot"] = { "<cmd>ObsidianTags<cr>", "All occurences of tag" },
    ["<leader>od"] = { "<cmd>ObsidianDailies<cr>", "All dailies" },
    ["<leader>os"] = { "<cmd>ObsidianSearch<cr>", "Search" },
    ["<leader>ol"] = { "<cmd>ObsidianLink<cr>", "Link selection to note" },
    ["<leader>om"] = { "<cmd>ObsidianLinkNew<cr>", "Link selection to new note" },
    ["<leader>oc"] = { "<cmd>ObsidianLinks<cr>", "All links within the buffer" },
    ["<leader>oy"] = { "<cmd>ObsidianExtractNote<cr>", "Extract selected text into a new note and link" },
    ["<leader>op"] = { "<cmd>ObsidianPasteImg<cr>", "Paste image" },
    ["<leader>ox"] = { "<cmd>ObsidianRename<cr>", "Rename" },
  }

  require("obsidian").setup({
    workspaces = {
      {
        name = "Obsidian",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/",
      },
    },
  })
end

return M


