return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim", {
    's1n7ax/nvim-window-picker',
    tag = "v1.*",
    config = function()
      require'window-picker'.setup({
        autoselect_one = true,
        include_current = true,
        filter_rules = {
          bo = {
            filetype = {'neo-tree', "neo-tree-popup", "notify"},
            buftype = {'terminal', "quickfix"}
          }
        },
        other_win_hl_color = '#e35e4f'
      })
    end
  }
}
