-- file_manager.lua
local function get_files_and_dirs(path)
  local files_and_dirs = {}
  local p = io.popen('find "' .. path .. '" -maxdepth 1 -type d -o -type f')
  for file in p:lines() do
    local relative_path = file:gsub(path .. "/", "")
    table.insert(files_and_dirs, relative_path)
  end
  return files_and_dirs
end

local function open_file(file)
  local path = vim.fn.expand('%:p:h')
  vim.cmd('edit ' .. path .. '/' .. file)
end

local function file_manager()
  local path = vim.fn.expand('%:p:h')
  local files_and_dirs = get_files_and_dirs(path)
  local file_picker = {}
  for _, file in ipairs(files_and_dirs) do
    table.insert(file_picker, {file, function() open_file(file) end})
  end
  local lines = {}
  for index, item in ipairs(file_picker) do
    table.insert(lines, string.format("%d. %s", index, item[1]))
  end
  local choice = vim.fn.inputlist(lines)
  if choice < 1 or choice > #file_picker then
    return
  end
  file_picker[choice][2]()
end

return file_manager
