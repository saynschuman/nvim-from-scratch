local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  'tpope/vim-fugitive', {"catppuccin/nvim", name = "catppuccin"}, {
    'nvim-lualine/lualine.nvim',
    opts = require("plugins.lualine")
  }, {
    "folke/which-key.nvim",
    config = require("plugins.which_key")
  }, {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = require("plugins.neo_tree_deps"),
    config = require("plugins.neo_tree")
  },
{
  'kdheepak/tabline.nvim',
  config = require("plugins/tabline"),
  requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
}

})

