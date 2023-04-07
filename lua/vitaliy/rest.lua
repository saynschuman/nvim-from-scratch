local M = {}

local function parse_http_file()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local url, headers = nil, {}

  for _, line in ipairs(lines) do
    if not url then
      local method, request_url = string.match(line, "^(%u+)%s+(.+)$")
      if method and request_url then url = request_url end
    else
      local key, value = string.match(line, "^(.-):%s*(.+)$")
      if key and value then headers[key] = value end
    end
  end

  return url, headers
end

local function pretty_json(json_str)
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
  vim.api.nvim_command("rightbelow vnew")
  -- Задаем тип файла для подсветки синтаксиса
  vim.api.nvim_command("set filetype=json")
  vim.api.nvim_buf_set_lines(0, 0, -1, false,
                             vim.split(pretty_response, "\n", {}))
end

M.exec = function()
  local url, headers = parse_http_file()
  if url then
    get_request(url, headers)
  else
    print("Error: Unable to parse the current file")
  end
end

return M
