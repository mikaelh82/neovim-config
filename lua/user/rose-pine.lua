local M = {
  "rose-pine/neovim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
}

function M.config()
  vim.cmd.colorscheme "rose-pine"
end

return M
