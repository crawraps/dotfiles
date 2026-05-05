import QtQuick
import QtQuick.Controls

TextField {
  id: root

  placeholderText: qsTr("search")
  color: appearance.getColor("foreground")
  placeholderTextColor: appearance.getColor("foreground", .5)
  font.family: appearance.data.font.family.regular
  font.pointSize: appearance.data.font.size.m
  padding: appearance.data.spacing.medium
  selectionColor: appearance.getColor("primary", .2)

  property int debounce: 300
  Timer { id: localTimer; interval: debounce; repeat: false; onTriggered: { root.debouncedTextChanged() } }

  onTextChanged: {
    localTimer.restart()
  }

  background: Rectangle {
    color: appearance.getColor("background", true)
    radius: appearance.data.rounding.medium
  }
}
