vim.opt.number = true
vim.opt.relativenumber = true
-- Установка leader
vim.g.mapleader = ' '

vim.cmd('command! ReloadConfig source ~/.config/nvim/init.lua')
-- Перезагрузка файла конфигурации
vim.api.nvim_set_keymap('n', '<leader>r', ':ReloadConfig<CR>', { noremap = true, silent = true })
-- Отключение отображения символа тильда в незанятых строках
vim.opt.fillchars:remove('eob:~')
-- remove tilda at the end of buffer
vim.wo.fillchars='eob: '
-- Включение использования системного буфера обмена
vim.opt.clipboard:append('unnamedplus')


-- Определение нового цвета для StatusLine
vim.cmd [[
  highlight StatusLine ctermfg=0 ctermbg=0 guifg=#000000 guibg=#000000
  highlight StatusLineNC ctermfg=0 ctermbg=0 guifg=#000000 guibg=#000000
]]

-- Bзменение цвета номеров строк
-- vim.cmd [[
--  highlight LineNr ctermfg=0 ctermbg=0 guifg=#880000 guibg=#880000
--  highlight CursorLineNr ctermfg=1 ctermbg=1 guifg=#000000 guibg=#000000
-- ]]


-- init.lua
-- Импорт модуля file_manager и вызов функции file_manager
vim.api.nvim_set_keymap('n', '<Leader>f', ':lua require("file_manager")()<CR>', {noremap = true, silent = true})

