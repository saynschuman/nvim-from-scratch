
vim.api.nvim_set_keymap('n', '<leader>e', ':Lexplore<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-g>', ':Neotree float git_status<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-b>', ':G blame<cr>', {noremap = true, silent = true})
