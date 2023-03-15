-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Configuration for packer
packer.init { git = { clone_timeout = 300,}, }

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "jose-elias-alvarez/null-ls.nvim" } -- Better formatting
  use { "nvim-treesitter/nvim-treesitter" } -- treesitter, used for linting
  use { "windwp/nvim-ts-autotag" } -- Autotag used for jsx, tsx files
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" } -- Comment
  use { "JoosepAlviste/nvim-ts-context-commentstring" }  -- Helps in comment
  use { "nvim-telescope/telescope.nvim" } -- Telescope, a fuzzy finder
  use { "norcalli/nvim-colorizer.lua" } -- Shows colors
  use { "kyazdani42/nvim-web-devicons" } -- pretty icons
  use { "ellisonleao/gruvbox.nvim" }  -- gruvbox colorschemes
  use { "NTBBloodbath/doom-one.nvim" } -- doom one colorscheme
  use { "lukas-reineke/indent-blankline.nvim" } -- indent-blankline line
  use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast' } -- markdown preview
  use { "derektata/lorem.nvim" } -- Generate random text.
  use { "github/copilot.vim" } -- Github copilot
  use {'akinsho/bufferline.nvim', tag = "v3.*" } -- tab/bufferline

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
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


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
