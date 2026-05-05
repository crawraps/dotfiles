import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "root:/utils"

ToolTip {
  id: tooltip
  text: modelData.name
  font.family: appearance.data.font.family.regular
  font.pointSize: appearance.data.font.size.xs
  delay: 1000

  contentItem: Text {
    text: tooltip.text
    font: tooltip.font
    color: "white"
  }

  background: Rectangle {
    color: "#50000000"
    radius: appearance.data.rounding.small
  }
}
