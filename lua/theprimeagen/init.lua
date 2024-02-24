-- Load essential configurations and plugin initializations.
require("theprimeagen.set")    -- Import custom editor settings (UI, options, etc.).
require("theprimeagen.remap")  -- Load custom key mappings.
require("theprimeagen.packer") -- Initialize plugins specified in ThePrimeagen's packer config

-- Neovim API for creating autogroups, a method to organize autocommands.
local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

-- Define autogroup for highlighting yanked text.
local yank_group = augroup('HighlightYank', {})

-- Utility function for reloading Lua modules, useful during development.
function R(name)
    require("plenary.reload").reload_module(name, true)
end

-- Autocommand to highlight yanked text momentarily.
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({higroup = 'IncSearch', timeout = 40})
    end,
})

-- Autocommand to trim trailing whitespace before saving any file.
vim.api.nvim_create_autocmd("BufWritePre", {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Configure the map leader key.
vim.g.mapleader = " "
-- Key mapping for enhancing navigation.
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Netrw settings for file exploring.
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
