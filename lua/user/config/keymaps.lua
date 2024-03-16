-- # Keymap Descriptions

-- -----------------------------------------------------------
-- ## Leader and Local Leader Setup
-- -----------------------------------------------------------
-- Purpose:
-- Sets the "<Space>" as the leader key and local leader key. The leader key
-- serves as a prefix for triggering custom keybindings, enhancing efficiency
-- and providing a namespace for user-defined mappings.
-- -----------------------------------------------------------
local keymap = vim.keymap.set
local default_opts = { expr = false, noremap = true, silent = true }

keymap("n", "<Space>", "", default_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enhance 'with_desc' to accept additional options, defaulting 'expr' to false
local function with_desc(description, additional_opts)
    return vim.tbl_extend("force", default_opts, { desc = description }, additional_opts or {})
end
-- -----------------------------------------------------------
-- ## Better Movement Keys
-- -----------------------------------------------------------
-- Purpose:
-- Enhances the default movement keys (`j`, `k`, `<Down>`, `<Up>`) to respect
-- visual lines instead of actual lines, which is particularly useful in wrapped
-- text. This setup ensures a more intuitive navigation experience, especially
-- when dealing with long lines that wrap across multiple screen lines.
-- -----------------------------------------------------------
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", with_desc("Move down (visual line)", { expr = true}))
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", with_desc("Move down (visual line)", { expr = true}))
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", with_desc("Move up (visual line)", {expr = true}))
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", with_desc("Move up (visual line)", { expr = true}))

--- -----------------------------------------------------------
-- ## Move to Window Using the <ctrl> hjkl Keys
-- -----------------------------------------------------------
-- Purpose:
-- Enables quick navigation between split windows using Ctrl combined with hjkl keys,
-- mimicking the natural Vim movement keys but for window focus. This setup streamlines
-- the process of moving focus across split windows, enhancing productivity by allowing
-- quick and intuitive window switching without the need to leave the home row.
-- -----------------------------------------------------------
keymap("n", "<C-h>", "<C-w>h", with_desc("Go to left window"))
keymap("n", "<C-j>", "<C-w>j", with_desc("Go to lower window"))
keymap("n", "<C-k>", "<C-w>k", with_desc("Go to upper window"))
keymap("n", "<C-l>", "<C-w>l", with_desc("Go to right window"))

-- -----------------------------------------------------------
-- ## Resize Window Using <ctrl> Arrow Keys
-- -----------------------------------------------------------
-- Purpose:
-- Provides intuitive mappings for resizing the current window using Ctrl combined
-- with arrow keys. This setup allows for quick and easy adjustments to the window
-- layout, enhancing the user's ability to customize their workspace on the fly.
-- -----------------------------------------------------------
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", with_desc("Increase window height"))
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", with_desc("Decrease window height"))
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", with_desc("Decrease window width"))
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", with_desc("Increase window width"))

-- -----------------------------------------------------------
-- ## Move Lines
-- -----------------------------------------------------------
-- Purpose:
-- Introduces the ability to move lines or selections up and down with Alt + j/k
-- in normal, insert, and visual modes. This feature significantly improves the
-- efficiency of organizing and refactoring code or text blocks, allowing for
-- quick adjustments to the structure of your document without interrupting the
-- editing flow.
-- -----------------------------------------------------------
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", with_desc("Move line down"))
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", with_desc("Move line up"))
keymap("i", "<A-j>", "<esc><cmd>m .+1<CR>==gi", with_desc("Move line down in Insert mode"))
keymap("i", "<A-k>", "<esc><cmd>m .-2<CR>==gi", with_desc("Move line up in Insert mode"))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", with_desc("Move selection down"))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", with_desc("Move selection up"))

-- -----------------------------------------------------------
-- ## Buffer Navigation
-- -----------------------------------------------------------
-- Purpose:
-- Provides key mappings for efficient navigation between open buffers,
-- enabling quick switching to previous, next, or the last accessed buffer.
-- This feature enhances workflow fluidity, making it easier to manage
-- multiple files within the same Neovim session.
-- -----------------------------------------------------------
keymap("n", "<S-h>", "<cmd>bprevious<CR>", with_desc("Prev buffer"))
keymap("n", "<S-l>", "<cmd>bnext<CR>", with_desc("Next buffer"))
keymap("n", "<leader>bb", "<cmd>e #<CR>", with_desc("Switch to Other Buffer"))

-- -----------------------------------------------------------
-- ## Clear Search Highlighting with <esc>
-- -----------------------------------------------------------
-- Purpose:
-- Enhances the <esc> key to clear search highlighting when pressed in normal mode,
-- while preserving its default functionality in insert mode. This feature allows for
-- a seamless workflow, enabling quick clearing of search highlights without adding
-- extra steps or requiring separate keybindings.
-- -----------------------------------------------------------

-- Clear search highlighting in normal mode with <esc>
keymap("n", "<esc>", "<cmd>noh<CR><esc>", with_desc("Escape and clear hlsearch in Normal mode"))

-- For insert mode, ensure <esc> first returns to normal mode before clearing highlights
-- This ensures that the default behavior of <esc> (exiting insert mode) is preserved
keymap("i", "<esc>", "<esc><cmd>noh<CR>", with_desc("Return to Normal mode and clear hlsearch"))

-- -----------------------------------------------------------
-- ## Search Result Navigation
-- -----------------------------------------------------------
-- Purpose:
-- Facilitates efficient navigation through search results by customizing the behavior
-- of 'n' and 'N' commands in normal, visual, and operator-pending modes. These mappings
-- enhance productivity by providing quick access to the next or previous search result
-- without interrupting the editing flow.
-- -----------------------------------------------------------

-- Define options for search result navigation
local search_opts = with_desc("Search result navigation", { expr = true })

-- Map 'n' to navigate to the next search result
keymap("n", "n", "'Nn'[v:searchforward].'zv'", search_opts)

-- Map 'N' to navigate to the previous search result
keymap("n", "N", "'nN'[v:searchforward].'zv'", search_opts)

-- For visual mode, maintain consistency by using the same behavior
keymap("x", "n", "'Nn'[v:searchforward]", search_opts)
keymap("x", "N", "'nN'[v:searchforward]", search_opts)

-- For operator-pending mode, maintain consistency by using the same behavior
keymap("o", "n", "'Nn'[v:searchforward]", search_opts)
keymap("o", "N", "'nN'[v:searchforward]", search_opts)

-- -----------------------------------------------------------
-- ## Add undo breakpoints in insert mode
-- -----------------------------------------------------------
-- Purpose:
-- Inserts undo breakpoints for specific characters (comma, period, semicolon)
-- in insert mode. This feature enables finer control over the undo behavior
-- for these characters, facilitating smoother editing and correction workflows.
-- -----------------------------------------------------------
keymap("i", ",", ",<c-g>u", with_desc("Insert undo breakpoint for comma"))
keymap("i", ".", ".<c-g>u", with_desc("Insert undo breakpoint for period"))
keymap("i", ";", ";<c-g>u", with_desc("Insert undo breakpoint for semicolon"))

-- -----------------------------------------------------------
-- ## Save file
-- -----------------------------------------------------------
-- Purpose:
-- Maps the key combination <Ctrl-S> in insert, normal, visual, and select
-- modes to save the current file. This provides a quick and efficient way
-- to save changes without leaving the current mode, enhancing productivity
-- during editing sessions.
-- -----------------------------------------------------------
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR>", with_desc("Save file"))

-- -----------------------------------------------------------
-- ## Keyword program
-- -----------------------------------------------------------
-- Purpose:
-- Assigns the leader key followed by 'K' to execute the 'K' command in normal
-- mode, providing a quick way to run a keyword program. This enhances
-- navigation and interaction with the current document.
-- -----------------------------------------------------------
keymap("n", "<leader>K", "<cmd>norm! K<CR>", with_desc("Keywordprg"))

-- -----------------------------------------------------------
-- ## Better indenting
-- -----------------------------------------------------------
-- Purpose:
-- Enhances the behavior of the '<' and '>' keys in visual mode by ensuring
-- that the selection is properly indented after using these keys. This
-- improves code readability and formatting.
-- -----------------------------------------------------------
keymap("v", "<", "<gv", with_desc("Indent selection left"))
keymap("v", ">", ">gv", with_desc("Indent selection right"))

-- -----------------------------------------------------------
-- ## New file
-- -----------------------------------------------------------
-- Purpose:
-- Maps the leader key followed by 'fn' to create a new file. This provides
-- a quick way to initiate a new editing session without disrupting the
-- current workflow.
-- -----------------------------------------------------------
keymap("n", "<leader>fn", "<cmd>enew<CR>", with_desc("New File"))

-- -----------------------------------------------------------
-- ## Location and Quickfix Lists
-- -----------------------------------------------------------
-- Purpose:
-- Assigns the leader key followed by 'xl' to open the location list, and
-- leader key followed by 'xq' to open the quickfix list. These mappings
-- provide efficient access to navigation aids for managing errors and
-- locations within the current buffer.
-- -----------------------------------------------------------
keymap("n", "<leader>xl", "<cmd>lopen<CR>", with_desc("Location List"))
keymap("n", "<leader>xq", "<cmd>copen<CR>", with_desc("Quickfix List"))

-- -----------------------------------------------------------
-- ## Quickfix navigation
-- -----------------------------------------------------------
-- Purpose:
-- These keymaps allow navigation between quickfix entries.
-- They provide a convenient way to move through compiler or
-- linter messages, helping developers to quickly address
-- issues in their code.
-- -----------------------------------------------------------
keymap("n", "[q", "<cmd>cprevious<CR>", with_desc("Previous quickfix"))
keymap("n", "]q", "<cmd>cnext<CR>", with_desc("Next quickfix"))

-- -----------------------------------------------------------
-- ## Quit
-- -----------------------------------------------------------
-- Purpose:
-- This keymap enables quick quitting of all open buffers.
-- It provides a fast way to close Vim when finished working.
-- -----------------------------------------------------------
keymap("n", "<leader>qq", "<cmd>qa<CR>", with_desc("Quit all"))

-- -----------------------------------------------------------
-- ## Inspect position
-- -----------------------------------------------------------
-- Purpose:
-- This keymap displays the current cursor position in the
-- status line. It's useful for checking the line and column
-- number while navigating through a document.
-- -----------------------------------------------------------
keymap("n", "<leader>ui", "<cmd>echo 'Cursor at '.line('.').' line, '.col('.').' column'<CR>", with_desc("Inspect Pos"))
