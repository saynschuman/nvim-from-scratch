local M = {}

function get_request(url, headers)
  local header_cmd = ""

  if headers ~= nil then
    for key, value in pairs(headers) do
      header_cmd = header_cmd .. "-H '" .. key .. ": " .. value .. "' "
    end
  end

  local cmd = "curl -s " .. header_cmd .. "-o - " .. url
  local handle = io.popen(cmd)

  if handle == nil then
    print("Error: Unable to execute curl command")
    return nil
  end

  local response = handle:read("*a")
  handle:close()

  if response == nil then
    print("Error: Unable to read response from server")
    return nil
  end

  -- Открываем новый вертикальный split-окно и выводим ответ в нем
  vim.api.nvim_command("vnew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(response, "\n", {}))
end

local url = "https://api-sandbox.liquidplc.com/api-framework/contenttypes/"
local headers = {
  ["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwOTI5MzEwLCJpYXQiOjE2ODA4ODYxMTAsImp0aSI6IjNjNDhhM2E3MGZiNDQxMWM5ZWUyMWMwOWI0MjFiYWJmIiwidXNlcl9pZCI6Nn0.ibirce0d4jmBE9plf1FR71hGi1tBIZIfq6L4Lgky81c",
  ["Content-Type"] = "application/json"
}

M.exec = function() get_request(url, headers) end

return M
