local get_data = ya.sync(function()
  local file = cx.active.current.hovered

  return tostring(file.url), file:mime()
end)

return {
  entry = function()
    local path, mime = get_data()

    if mime == nil or mime:find("image") == nil then
      return
    end

    local cat = Command("cat"):arg(path):stdout(Command.PIPED):spawn()
    local _, err = Command("wl-copy"):stdin(cat:take_stdout()):stdout(Command.PIPED):spawn():wait()

    if err ~= nil then
      return ya.notify {
        title = "Yank image",
        content = "Failed to copy image to clipboard. ErrorCode: " .. err,
        timeout = 3,
        layer = 'error'
      }
    end
  end,
}
