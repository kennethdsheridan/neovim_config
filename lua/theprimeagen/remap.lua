-- Set leader key to space for convenience
vim.g.mapleader = " "

-- Terminal keybindings
-- Open a terminal shell session
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })

-- Project navigation
-- Open project explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Movement enhancements
-- Move selected line/block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Center screen on navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Collaboration tools
-- Start and stop collaborative editing sessions
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- Clipboard enhancements
-- Paste over without overwriting the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without affecting the clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Miscellaneous
-- Cancel input mode with Ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable the Q command
vim.keymap.set("n", "Q", "<nop>")

-- Open tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Formatting
-- Format buffer using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Navigation in quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Configuration and utilities
-- Open Neovim packer configuration
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

-- Fun and games
-- Trigger a custom command for fun
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Reload Neovim configuration
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")

-- This command sets a key mapping for the insert mode ('i') in Neovim.
-- When the <Tab> key is pressed, it calls the 'tabnine#expand_or_advance()' function.
-- The {expr = true} option indicates that the right-hand side is an expression that will be evaluated to get the actual keys to send.
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tabnine#expand_or_advance()', {expr = true})

-- Similarly, this command sets a key mapping for the insert mode ('i') in Neovim.
-- When the <S-Tab> (Shift + Tab) is pressed, it calls the 'tabnine#jump_backwards()' function.
-- The function is meant to navigate backwards in the completion suggestion list.
-- Again, {expr = true} option is used to indicate that the command is an expression.
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.tabnine#jump_backwards()', {expr = true})

end)
