-- -----------------------------------------------------------
-- 
-- # Autocommands descriptions
--
-- -----------------------------------------------------------

-- -----------------------------------------------------------
--
-- # Event Descriptions
--
-- -----------------------------------------------------------
-- ## Event: BufWinEnter
-- -----------------------------------------------------------
-- Description:
-- Triggered every time a window displaying a buffer is entered. This can occur
-- when opening a new file, switching between windows, or displaying a buffer in
-- a window for the first time. Useful for setting buffer-local options or
-- initializing buffer-specific functionality.

-- -----------------------------------------------------------
-- ## Event: FileType
-- -----------------------------------------------------------
-- Description:
-- This event is triggered after setting the filetype of a buffer. The filetype
-- is set when a file is loaded or when the filetype of a buffer is changed
-- manually. It is utilized to apply specific settings or execute custom scripts
-- for different types of files, facilitating filetype-specific configurations.

-- -----------------------------------------------------------
-- ## Event: CmdWinEnter
-- -----------------------------------------------------------
-- Description:
-- Occurs when entering the command-line window, a special buffer for entering
-- multi-line commands, accessible via commands like :q: or :helpgrep. This event
-- can be used to modify the behavior or appearance of the command-line window.

-- -----------------------------------------------------------
-- ## Event: VimResized
-- -----------------------------------------------------------
-- Description:
-- Triggered when the main Vim/Neovim window is resized. This is relevant for
-- both GUI versions of Vim/Neovim and terminal sessions where the Vim/Neovim
-- window size changes. Allows for dynamic adjustment of settings or layouts in
-- response to window size changes.

-- -----------------------------------------------------------
-- ## Event: TextYankPost
-- -----------------------------------------------------------
-- Description:
-- Occurs immediately after text has been yanked (copied) into a register. This
-- event enables the provision of visual feedback or the execution of specific
-- functions following a yank operation, enhancing the yanking experience.

-- -----------------------------------------------------------
-- ## Event: CursorHold
-- -----------------------------------------------------------
-- Description:
-- Triggered when the cursor is held in the same position for a certain amount of
-- time (defined by the `updatetime` setting). Often used for displaying hover
-- documentation or initiating other passive actions based on the cursor's
-- location, improving the information accessibility and user interaction.
-- -----------------------------------------------------------

-- -----------------------------------------------------------
-- ## Event: BufWritePre / BufWritePost
-- -----------------------------------------------------------
-- Description:
-- These events are triggered right before (BufWritePre) and right after (BufWritePost)
-- a buffer is written to a file. They are ideal for performing actions like
-- auto-formatting code, cleaning up whitespace, or auto-generating documentation
-- before saving changes to disk or after the save has been completed.

-- -----------------------------------------------------------
-- ## Event: BufReadPost
-- -----------------------------------------------------------
-- Description:
-- Triggered after a file is read into a buffer. This event is particularly useful
-- for tasks that need to be done right after a file is opened, such as restoring
-- the cursor to its last position within the file or setting up buffer-specific
-- settings that were not handled by FileType autocommands.

-- -----------------------------------------------------------
-- ## Event: FileType (additional usage)
-- -----------------------------------------------------------
-- Description:
-- While the FileType event is triggered after setting a buffer's filetype, additional
-- usage can involve more granular customization for various file types not initially
-- covered. This can include applying specific settings, enabling or disabling plugins,
-- or custom key mappings for an enhanced editing experience in those file types.

-- -----------------------------------------------------------
-- ## Event: WinEnter / WinLeave
-- -----------------------------------------------------------
-- Description:
-- WinEnter is triggered when entering a window, and WinLeave when leaving one.
-- These events can be used to adjust the appearance or behavior of the Neovim
-- interface depending on the active or inactive window. This could involve changing
-- the status line, modifying gutter colors, or enabling/disabling certain visual
-- aids to highlight the currently focused window or de-emphasize inactive ones.

-- -----------------------------------------------------------
-- ## Event: InsertEnter / InsertLeave
-- -----------------------------------------------------------
-- Description:
-- InsertEnter is triggered when entering insert mode, and InsertLeave when leaving
-- insert mode. These events allow for the dynamic adjustment of settings or features
-- that should only be active during insert mode, such as auto-completion, linting on
-- the fly, or other insert-mode-specific behaviors that enhance the typing or coding
-- experience.

-- -----------------------------------------------------------
-- ## Event: SessionLoadPost
-- -----------------------------------------------------------
-- Description:
-- Triggered after a session is loaded. This event is useful for reapplying settings,
-- performing cleanup tasks, or reinitializing plugins that may not have been restored
-- to their desired state by the session load process. It ensures that your working
-- environment is exactly as you expect it to be, even after restoring from a session.

-- -----------------------------------------------------------
-- 
-- # Pattern Descriptions
--
-- -----------------------------------------------------------
-- ## Understanding the 'pattern' Argument in nvim_create_autocmd
-- -----------------------------------------------------------
-- Description:
-- The 'pattern' argument in the nvim_create_autocmd function specifies which
-- buffers or files the autocommand applies to. This granular control mechanism
-- enables the execution of autocommands based on specific criteria such as file
-- types, names, or patterns. Patterns can be set for a wide range of scenarios:
--
-- ### 1. File Types:
-- -----------------------------------------------------------
--    Apply autocommands to files of specific types by using the 'FileType'
--    event with patterns matching file type names (e.g., 'lua', 'python').
--
--       Example: {"FileType"}, {pattern = {"lua", "python"}, callback = ...}
--
-- ### 2. File Patterns:
-- ---------------------------------------------------------
--    Target files matching specific glob patterns or names. Useful for applying
--    autocommands to files with certain extensions or within specific directories.
--
--       Example: {"BufRead", "BufNewFile"}, {pattern = "*.txt", callback = ...}
--
-- ### 3. Buffers:
-- ---------------------------------------------------------
--    Directly target specific buffers by their IDs, allowing for very targeted
--    autocommand execution.
--
--       Example: {"BufWritePre"}, {pattern = "<buffer_id>", callback = ...}
--
-- ### Key Points:
-- ---------------------------------------------------------
-- - A pattern of "*" signifies the autocommand should apply universally to all
--   applicable scenarios.
-- - Vim's file matching conventions allow for complex pattern matching, leveraging
--   glob patterns for broad or specific matching criteria.
-- - Certain events do not require or use the 'pattern' field, particularly those
--   not directly related to file or buffer content.
--
-- This argument's flexibility is pivotal for customizing Neovim behavior, ensuring
-- autocommands are executed only under appropriate conditions, thereby optimizing
-- performance and relevance.

-- ---------------------------------------------------------
--
-- # Autocommands
--
-- -----------------------------------------------------------
-- ## Autocommand 1: BufWinEnter
-- -----------------------------------------------------------
-- Purpose:
-- Disables automatic comment continuation when starting a new line in any buffer.
-- This autocommand is triggered every time a buffer window is entered, ensuring
-- that automatic comment prefixes are not added unexpectedly.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 2: FileType
-- -----------------------------------------------------------
-- Purpose:
-- Sets up specific behaviors for a variety of file types to enhance user experience.
-- This includes disabling buffer listing and setting up a keybinding for quickly
-- closing the buffer with 'q' in selected file types.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {
    "netrw", "Jaq", "qf", "git", "help", "man", "lspinfo", "oil",
    "spectre_panel", "lir", "DressingSelect", "tsplayground", "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 3: CmdWinEnter
-- -----------------------------------------------------------
-- Purpose:
-- Automatically closes the command-line window upon entering it.
-- This streamlines the workflow by avoiding unnecessary interactions with
-- the command-line window, which Neovim opens for certain commands.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"CmdWinEnter"}, {
  callback = function()
    vim.cmd "quit"
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 4: VimResized
-- -----------------------------------------------------------
-- Purpose:
-- Adjusts all window sizes equally when the main Vim window is resized.
-- This ensures a balanced, visually pleasing layout across all open windows,
-- enhancing the overall editing experience.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"VimResized"}, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 5: BufWinEnter
-- -----------------------------------------------------------
-- Purpose:
-- Checks for external changes to the file currently being edited.
-- This autocommand is triggered every time a buffer window is entered, ensuring
-- that the editor's content is always in sync with external modifications.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*"},
  callback = function()
    vim.cmd "checktime"
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 6: TextYankPost
-- -----------------------------------------------------------
-- Purpose:
-- Highlights yanked text for a brief moment to provide visual feedback.
-- This feature enhances usability by clearly indicating which text has been
-- copied into the Neovim yank register.
-- ö-----------------------------------------------------------
vim.api.nvim_create_autocmd({"TextYankPost"}, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 7: FileType
-- -----------------------------------------------------------
-- Purpose:
-- Enables word wrap and spell checking for specific file types that are
-- frequently used for writing and documentation, such as git commit messages,
-- markdown files, and Neogit commit messages.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"gitcommit", "markdown", "NeogitCommitMessage"},
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 8: CursorHold
-- -----------------------------------------------------------
-- Purpose:
-- Facilitates the expansion or navigation of snippets in LuaSnip, improving
-- snippet usability. This is particularly useful for users who frequently
-- work with snippets and require efficient ways to navigate and manage them.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd({"CursorHold"}, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 9: BufWritePre/BufWritePost
-- -----------------------------------------------------------
-- Purpose:
-- Triggered before and after a buffer is written to a file. Useful for
-- auto-formatting code, cleaning up whitespace, or generating tags. This
-- example demonstrates auto-formatting files before saving.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.py", "*.js", "*.html"},
  callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end,
})

-- -----------------------------------------------------------
-- ## Autocommand 10: BufReadPost
-- -----------------------------------------------------------
-- Purpose:
-- Occurs after a file is read into a buffer. It can adjust the cursor position
-- to the last known position when reopening a file, enhancing user experience
-- by providing continuity.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd "normal! g'\""
    end
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 11: WinEnter/WinLeave
-- -----------------------------------------------------------
-- Purpose:
-- Triggered when entering or leaving a window. This can be used to adjust
-- settings or UI elements based on the focused window, such as highlighting
-- the active window to enhance visibility and focus.
-- -----------------------------------------------------------
-- Example template for WinEnter, you can create a similar one for WinLeave.
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    -- Your logic to highlight the active window or adjust settings
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 12: InsertEnter/InsertLeave
-- -----------------------------------------------------------
-- Purpose:
-- Triggered when entering and leaving insert mode. These can activate or
-- deactivate features that are only needed during insert mode, aiding
-- performance and focus.
-- -----------------------------------------------------------
-- Example template for InsertEnter, you can create a similar one for InsertLeave.
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    -- Your logic for enabling features or settings specific to insert mode
  end,
})

-- -----------------------------------------------------------
-- ## Autocommand 13: SessionLoadPost
-- -----------------------------------------------------------
-- Purpose:
-- Useful if you use sessions to save and restore workspaces. This autocommand
-- can help reapply settings or perform cleanup tasks after a session is loaded,
-- ensuring your environment is just as you left it.
-- -----------------------------------------------------------
vim.api.nvim_create_autocmd("SessionLoadPost", {
  callback = function()
    -- Your logic to reapply settings or cleanup
  end,
})


