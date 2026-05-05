import QtQuick

Text {
  property real fill

  font.family: appearance.data.font.family.icons
  font.pointSize: appearance.data.font.size.icon
  font.variableAxes: ({
    FILL: fill.toFixed(1)
  })
}
