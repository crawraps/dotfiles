import QtQuick

Text {
  renderType: Text.NativeRendering
  textFormat: Text.PlainText
  color: appearance.getColor("foreground")
  font.family: appearance.data.font.family.regular
  font.pointSize: appearance.data.font.size.s

  Behavior on color {
    ColorAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.InQuad
    }
  }
}
