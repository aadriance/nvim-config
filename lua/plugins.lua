-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
  }
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'mofiqul/dracula.nvim' -- Theme
  use({
	"catppuccin/nvim",
	as = "catppuccin"
  })
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'romgrk/barbar.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'saadparwaiz1/cmp_luasnip'
  use 'tversteeg/registers.nvim' -- " in normal mode or Ctrl R to open register list
  use 'jbyuki/venn.nvim'
  use 'jakewvincent/mkdnflow.nvim'
  use {"ellisonleao/glow.nvim", branch = 'main'}
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
end)
