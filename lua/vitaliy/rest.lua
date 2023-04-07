local M = {}

local function get_request(url)
  local cmd = "curl -s -o - " .. url
  local handle = io.popen(cmd)

  if handle == nil then return nil end

  local response = handle:read("*a")
  handle:close()

  -- Открываем новый вертикальный split-окно и выводим ответ в нем
  vim.api.nvim_command("vnew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(response, "\n", {}))
end

M.exec =
    function() get_request("https://jsonplaceholder.typicode.com/todos/1") end

return M
