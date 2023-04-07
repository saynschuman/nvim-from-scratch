vim.g.mapleader = " "

vim.keymap.set("n", "<leader>h", function()
  package.loaded.rest = nil
  require("vitaliy.rest").exec()
end)
