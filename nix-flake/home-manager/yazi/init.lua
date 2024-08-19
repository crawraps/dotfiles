function Status:name()
  local h = self._tab.current.hovered

  if not h then
    return ui.Line {}
  end

  local linked = ""
  if h.link_to ~= nil then
    linked = " -> " .. tostring(h.link_to)
  end

  return ui.Line(" " .. h.name .. linked)
end

function Entity:symlink()
  if not MANAGER.show_symlink then
    return ui.Line {}
  end

  local to = self._file.link_to
  return ui.Line(to and { ui.Span(" ↗") } or {})
end
