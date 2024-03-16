-- -----------------------------------------------
--
-- # Config: Keymaps, Options, Autocmds, Colorscheme
--
-- -----------------------------------------------
require "user.config.spec"
require "user.config.keymaps"
require "user.config.options"
require "user.config.autocmds"

-- --------------------------------
--
-- # Plugins
--
-- --------------------------------

-- ## Colorschemes
-- --------------------------------
spec "user.rose-pine"
spec "user.tokyonight"

-- ## AI
-- --------------------------------
spec "user.copilot"

-- ## Icon sets
-- --------------------------------
spec "user.devicons"

-- ## Note taking
-- --------------------------------
spec "user.obsidian"

-- ## UI / Window Management
-- --------------------------------
spec "user.tabby"
spec "user.treesitter"
spec "user.alpha"
spec "user.illuminate"
spec "user.navic"
spec "user.breadcrumbs"
spec "user.lualine"
spec "user.indentline"
spec "user.toggleterm"
spec "user.dressing"

-- ## GIT
-- --------------------------------
spec "user.gitsigns"
spec "user.neogit"

-- ## LSP
-- --------------------------------
spec "user.lspconfig"
spec "user.mason"
spec "user.cmp"
spec "user.none-ls"

-- ## Search / Navigation / Finding
-- --------------------------------
spec "user.telescope"
spec "user.whichkey"
spec "user.project"
spec "user.nvimtree"
spec "user.harpoon"
spec "user.neoscroll"

-- ## Coding
-- ---------------------------------
spec "user.comment"
spec "user.autopairs"
spec "user.colorizer"
spec "user.eyeliner"
spec "user.navbuddy"

-- ## For Fun
-- ---------------------------------
spec "user.cellular-automaton"

-- ## Lazy
-- ---------------------------------
require "user.lazy"
