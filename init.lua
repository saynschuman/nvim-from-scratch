-- Отключение создания файлов swap
vim.o.swapfile = false

-- Включение отображения номеров строк
vim.opt.number = true

-- Отключение отображения относительных номеров строк
vim.opt.relativenumber = false 

-- Установка leader
vim.g.mapleader = ' '

-- Установка комбинации клавиш для перезагрузки файла конфигурации
vim.api.nvim_set_keymap('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Установка пустого символа в конце буфера
vim.wo.fillchars='eob: '

-- Включение использования системного буфера обмена
vim.opt.clipboard:append('unnamedplus')

-- Определение нового цвета для StatusLine
vim.cmd [[
  highlight StatusLine ctermfg=8 ctermbg=7 guifg=#ffffff guibg=#ffffff
  highlight StatusLineNC ctermfg=8 ctermbg=7 guifg=#ffffff guibg=#ffffff
]]

-- Установка цвета номеров строк на серый
vim.cmd('highlight LineNr ctermfg=darkgray')

-- Отключение баннера в netrw
vim.g.netrw_banner = 0

-- Изменение стиля списка файлов в netrw
vim.g.netrw_list_style = 3

-- Задание размера окна для netrw
vim.g.netrw_winsize = 25

-- Установка комбинации клавиш для открытия/закрытия файлового менеджера
vim.api.nvim_set_keymap('n', '<leader>e', ':Lexplore<CR>', { noremap = true, silent = true })

-- Переназначение комбинации клавиш Shift+h на перемещение к предыдущей вкладке
vim.api.nvim_set_keymap('n', '<S-h>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Переназначение комбинации клавиш Shift+l на перемещение к следующей вкладке
vim.api.nvim_set_keymap('n', '<S-l>', ':tabnext<CR>', { noremap = true, silent = true })

-- Установка комбинации клавиш для закрытия текущего буфера
vim.api.nvim_set_keymap('n', '<leader>c', ':bd<CR>', { noremap = true, silent = true })
