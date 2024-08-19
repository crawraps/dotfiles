local get_cwd = ya.sync(function()
  local cwd = cx.active.current.cwd

  return tostring(cwd)
end)

function get_file_name()
  local value, event = ya.input({
    title = "File name:",
    position = {
      "bottom-center",
      w = 48,
      h = 3,
      x = 0,
      y = -1,
    },
  })

  if event ~= 1 then
    return nil
  end

  return value
end

function check_file_exists(file)
  local out = Command('test'):args({ '-e', file }):output()

  return out.status.code == 0
end

function request_confirmation()
  local cand = ya.which({
    cands = {
      { on = 'o', desc = "overwrite file" },
      { on = 'c', desc = "cancel" },
    },
  })

  return cand == 1
end

function log_error(message)
  return ya.notify {
    title = "Paste file",
    content = message,
    timeout = 3,
    layer = "error"
  }
end

return {
  entry = function(self, args)
    local cwd = get_cwd()
    local name = get_file_name()

    if name == nil then
      return
    end

    local delimeter = ya.target_family() == "windows" and "\\" or "/"
    local path = cwd .. delimeter .. name
    local is_file_exists = check_file_exists(path)

    if is_file_exists then
      if args[1] ~= "quiet" then
        ya.notify {
          title = "Paste file",
          content = "File already exists. Choose option",
          timeout = 3,
        }
      end

      local is_rewrite_confirmed = request_confirmation()

      if not is_rewrite_confirmed then
        return
      end
    end

    local touch_output = Command('touch'):args({ path }):output()

    if touch_output.status.code ~= 0 then
      return log_error("Failed to create file")
    end

    local clip = ya.clipboard()
    local url = Url(path)

    local ok, err = fs.write(url, clip)

    if not ok then
      return err("Failed to write to file")
    end
  end,
}
