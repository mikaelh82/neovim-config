local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local dashboard = require "alpha.themes.dashboard"
  local icons = require "user.icons"

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Include"
    return b
  end

  dashboard.section.header.val = {
    [[ ★　✯   🛸                    🪐   .°•    |    ]],
    [[    __     ° ★　•       🛰       __      / \   ]],
    [[   / /   ____ ___  ______  _____/ /_    | O |  ]],
    [[  / /   / __ `/ / / / __ \/ ___/ __ \   | O |  ]],
    [[ / /___/ /_/ / /_/ / / / / /__/ / / /  /| | |\ ]],
    [[/_____/\__,_/\__,_/_/ /_/\___/_/ /_/  /_(.|.)_\]],
  }

  dashboard.section.buttons.val = {
    button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
    button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
    button("p", icons.git.Repo .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
    button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
    button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
    button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
  }

  dashboard.opts.opts.noautocmd = true
  require("alpha").setup(dashboard.opts)


end

return M
