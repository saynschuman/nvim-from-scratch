local M = {}

function pretty_json(json_str)
  local indent_level = 0
  local formatted_json = ""

  for i = 1, #json_str do
    local current_char = json_str:sub(i, i)

    if current_char == "{" or current_char == "[" then
      indent_level = indent_level + 1
      formatted_json = formatted_json .. current_char .. "\n" ..
                           string.rep("  ", indent_level)
    elseif current_char == "}" or current_char == "]" then
      indent_level = indent_level - 1
      formatted_json =
          formatted_json .. "\n" .. string.rep("  ", indent_level) ..
              current_char
    elseif current_char == "," then
      formatted_json = formatted_json .. current_char .. "\n" ..
                           string.rep("  ", indent_level)
    elseif current_char == ":" then
      formatted_json = formatted_json .. current_char .. " "
    else
      formatted_json = formatted_json .. current_char
    end
  end

  return formatted_json
end

local function get_request(url, headers)
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

  -- Форматируем JSON-ответ
  local pretty_response = pretty_json(response)

  -- Открываем новый вертикальный split-окно и выводим ответ в нем
  vim.api.nvim_command("vnew")
  -- Задаем тип файла для подсветки синтаксиса
  vim.api.nvim_command("set filetype=json")
  vim.api.nvim_buf_set_lines(0, 0, -1, false,
                             vim.split(pretty_response, "\n", true))
end

local url = "https://api-sandbox.liquidplc.com/api-framework/contenttypes/"
local headers = {
  ["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwOTI5MzEwLCJpYXQiOjE2ODA4ODYxMTAsImp0aSI6IjNjNDhhM2E3MGZiNDQxMWM5ZWUyMWMwOWI0MjFiYWJmIiwidXNlcl9pZCI6Nn0.ibirce0d4jmBE9plf1FR71hGi1tBIZIfq6L4Lgky81c",
  ["Content-Type"] = "application/json"
}

M.exec = function() get_request(url, headers) end

return M
