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

    -- Add Tabnine
  use {
    'codota/tabnine-nvim',
    after = 'nvim-cmp',
    config = function()
      -- Optional: configure Tabnine
      require('cmp').setup({
        sources = {
          { name = 'cmp_tabnine' },
        },
      })

      local tabnine = require('cmp_tabnine.config')
      tabnine:setup({
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = '..',
          ignored_file_types = {}, -- specify file types to ignore
          show_prediction_strength = false,
      })
    end,
    run = './install.sh', -- This command is deprecated in newer versions of the plugin. The plugin should auto-download the binary.
  }

use {
  'tzachar/cmp-tabnine',
  run = './install.sh',  -- Use this for Unix-like systems. Change to 'powershell ./install.ps1' on Windows if needed.
  after = 'nvim-cmp',
  requires = 'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require('cmp')
    cmp.setup {
      sources = cmp.config.sources({
        { name = 'cmp_tabnine' },
        -- Specify other sources you want to use. For example:
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- You can add more sources here following the pattern.
      }),
      -- Include any other configurations for nvim-cmp here.
      -- For example, snippet support, mapping, formatting, etc.
    }

    -- Additional TabNine configuration
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
        max_lines = 1000,  -- Max number of lines to provide suggestions for
        max_num_results = 20,  -- Max number of suggestions to show
        sort = true,  -- Whether to sort the suggestions provided by TabNine
        run_on_every_keystroke = true,  -- Get suggestions on every keystroke
        snippet_placeholder = '..',  -- Placeholder text for snippets
        show_prediction_strength = false,  -- Show prediction strength as inline text
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
