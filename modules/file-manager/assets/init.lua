require("hide-tab-bar"):setup { max_width = 20 }

Status:children_add(function(self)
  local h = self._current.hovered

  if not h or not h.cha.is_link or not h.link_to then
    return ""
  end

  return ui.Line {
    ui.Span(" -> " .. tostring(h.link_to)):fg("blue"),
  }
end, 3300, Status.LEFT)

Entity:children_add(function(self)
  local f = self._file
  if f.cha.is_link and f.link_to then
    return ui.Line { ui.Span(" ↗") }
  end
  return ui.Line {}
end, 3000)
