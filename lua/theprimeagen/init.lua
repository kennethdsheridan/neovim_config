-- Load essential configurations and plugin initializations.
require("theprimeagen.set")    -- Import custom editor settings (UI, options, etc.).
require("theprimeagen.remap")  -- Load custom key mappings.
require("theprimeagen.packer") -- Initialize plugins specified in ThePrimeagen's packer config

-- Neovim API for creating autogroups, a method to organize autocommands.
local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

-- Import the nvim-lspconfig plugin
local nvim_lsp = require('lspconfig')

-- Function to attach key mappings and other features when an LSP server attaches to a buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Define autogroup for highlighting yanked text.
local yank_group = augroup('HighlightYank', {})

-- Utility function for reloading Lua modules, useful during development.
function R(name)
    require("plenary.reload").reload_module(name, true)
end

-- Set column width indicator to 100
vim.opt.colorcolumn = "100"



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

        -- vim.lsp.buf.format is the function called to format the current buffer.
        -- This function asks the attached LSP server to format the code in the
        -- current buffer, according to the formatting rules the server provides.

        -- { timeout_ms = 2000 } is a table of options passed to vim.lsp.buf.format.
        -- timeout_ms specifies how long (in milliseconds) Neovim should wait for
        -- the LSP server to respond to the formatting request. In this case, it
        -- waits up to 2000 milliseconds (2 seconds) for a response. This timeout
        -- helps avoid hanging the editor if the LSP server is slow to respond or
        -- unresponsive.
vim.lsp.buf.format({ timeout_ms = 2000 })


-- Use Vimscript to define a custom function for opening LSP hover documentation.
vim.cmd [[
  " Define a function named OpenLSPHoverDoc.
  function! OpenLSPHoverDoc()
    " Check if there are active LSP clients for the current buffer.
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      " Trigger the LSP hover command, which shows documentation for the symbol under the cursor.
      lua vim.lsp.buf.hover()
      " Move the cursor to the rightmost window, assuming the documentation opened there.
      wincmd L
      " Resize the current window to be 20 columns wide.
      20wincmd _
    endif
  endfunction
]]

-- Set a Neovim keymap for the custom LSP hover documentation function.
-- This mapping uses the <leader>h combination to trigger the OpenLSPHoverDoc function.
vim.api.nvim_set_keymap('n', '<leader>h', ':call OpenLSPHoverDoc()<CR>', {
    noremap = true,  -- Ensure that the mapping is not recursive.
    silent = true    -- Do not echo any message when the mapping is used.
})

-- Usage:
-- Press <leader>h in normal mode to open LSP documentation for the symbol under the cursor,
-- if an LSP server is attached and active.


 -- Key mappings for LSP functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- Show hover information
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) -- Go to implementation
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts) -- Show signature help
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts) -- List all references
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- Go to definition
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts) -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Show code actions
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, bufopts) -- Format document
end

-- Configuration for rust_analyzer with additional help settings
nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      -- Enable hover documentation and links
      hover = {
        documentation = true,
        links = true,
      },
      -- Enable inlay hints for types and parameter names
      inlayHints = {
        enable = true,
        parameterHints = true,
        typeHints = true,
        chainingHints = true,
      },
      -- Additional rust_analyzer settings can be added here
      -- Example: diagnostics configuration to control the delay of message display
      diagnostics = {
        enable = true,
        disabled = {"unresolved-import"},
        enableExperimental = true,
      },
      -- Cargo settings to automatically watch and reload the project on changes
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        autoreload = true,
      },
      -- Proc macro settings for better macro expansion support
      procMacro = {
        enable = true,
      },
    },
  },
})



-- Go configuration with gopls
nvim_lsp.gopls.setup({
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

-- Python configuration with pyright
nvim_lsp.pyright.setup({
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})


-- Bash configuration with bashls
nvim_lsp.bashls.setup({
  on_attach = on_attach,
  -- Bash-specific settings can be added here if needed
})

-- C/C++ configuration with clangd
nvim_lsp.clangd.setup({
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--suggest-missing-includes" },
  settings = {
    clangd = {
      -- Clangd-specific settings can be added here if needed
    },
  },
})



-- Key mapping for copying to the main clipboard using <leader>Y
vim.keymap.set('n', '<leader>Y', '"+y', { noremap=true, silent=true }) -- Copy to clipboard
