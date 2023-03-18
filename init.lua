-- Отключение создания файлов swap
vim.o.swapfile = false

-- Включение отображения номеров строк
vim.opt.number = true

-- Определяем функцию для отображения файлового менеджера
function open_filemanager()
  -- Если менеджер уже открыт, скрываем его
  if vim.g.filemanager_open then
    vim.cmd(':Lexplore')
  else
    -- Иначе открываем менеджер и устанавливаем флаг
    vim.cmd(':Lexplore --immediate')
    vim.g.filemanager_open = true
  end
end

-- Отключение отображения относительных номеров строк
vim.opt.relativenumber = false 

-- Установка leader
vim.g.mapleader = ' '

-- Определение команды для перезагрузки файла конфигурации
vim.cmd('command! ReloadConfig source ~/.config/nvim/init.lua')

-- Установка комбинации клавиш для перезагрузки файла конфигурации
vim.api.nvim_set_keymap('n', '<leader>r', ':ReloadConfig<CR>', { noremap = true, silent = true })

-- Отключение отображения символа тильда в незанятых строках
vim.opt.fillchars:remove('eob:~')

-- Установка пустого символа в конце буфера
vim.wo.fillchars='eob: '

-- Включение использования системного буфера обмена
vim.opt.clipboard:append('unnamedplus')

-- Определение нового цвета для StatusLine
vim.cmd [[
  highlight StatusLine ctermfg=8 ctermbg=7 guifg=#ffffff guibg=#ffffff
  highlight StatusLineNC ctermfg=8 ctermbg=7 guifg=#ffffff guibg=#ffffff
]]

-- Отключение баннера в netrw
vim.g.netrw_banner = 0

-- Изменение стиля списка файлов в netrw
vim.g.netrw_list_style = 3

-- Задание размера окна для netrw
vim.g.netrw_winsize = 25

-- Определение функции для открытия/закрытия файлового менеджера
function toggle_filemanager()
  -- Если менеджер уже открыт, закрываем его и удаляем буфер
  if vim.g.filemanager_open then
    vim.cmd(':bd!')
    vim.g.filemanager_open = false
  else
    -- Иначе открываем менеджер и устанавливаем флаг
    vim.cmd(':Lexplore')
    vim.g.filemanager_open = true
  end
end

-- Определение функции для установки комбинации клавиш
function setup_keymap()
  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua toggle_filemanager()<CR>', { noremap = true, silent = true })
end

-- Установка комбинации клавиш для открытия/закрытия файлового менеджера
setup_keymap()

-- Переназначение комбинации клавиш Shift+h на перемещение к предыдущей вкладке
vim.api.nvim_set_keymap('n', '<S-h>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Переназначение комбинации клавиш Shift+l на перемещение к следующей вкладке
vim.api.nvim_set_keymap('n', '<S-l>', ':tabnext<CR>', { noremap = true, silent = true })

-- Установка комбинации клавиш для закрытия текущего буфера
vim.api.nvim_set_keymap('n', '<leader>c', ':bd<CR>', { noremap = true, silent = true })
