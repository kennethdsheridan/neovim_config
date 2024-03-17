-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', -- tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })


use {
  'tzachar/cmp-tabnine',
  run = './install.sh',  -- Use this for Unix-like systems. Change to 'powershell ./install.ps1' on Windows if needed.
  after = 'nvim-cmp',
  requires = {
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip', -- Adding LuaSnip as a requirement
    'rafamadriz/friendly-snippets' -- Adding friendly-snippets for additional snippets
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Load LuaSnip with friendly snippets
    require("luasnip/loaders/from_vscode").lazy_load()

    -- Setup nvim-cmp to use LuaSnip
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Use LuaSnip for expanding snippets
        end,
      },
      sources = cmp.config.sources({
        { name = 'cmp_tabnine' },
        { name = 'nvim_lsp' },
        -- Add more sources as needed
      }),
      -- Include any other configurations for nvim-cmp here
    }

    -- Additional TabNine configuration
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        show_prediction_strength = false,
    })
  end
}


  use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  })

  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,}

    -- Rustaceanvim for enhanced Rust development experience in Neovim
  -- This plugin provides various tools and functionalities specifically designed for Rust
  use {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended version to ensure compatibility and stability
    ft = { 'rust' }, -- This plugin will only load for Rust files, optimizing startup time
  }

  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")
  use("theprimeagen/refactoring.nvim")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  use("eandrju/cellular-automaton.nvim")
  use("laytan/cloak.nvim")

    end)


