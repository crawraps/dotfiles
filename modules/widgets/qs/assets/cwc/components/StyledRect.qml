import QtQuick

Rectangle {
  id: root

  color: "transparent"

  Behavior on color {
    ColorAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.InQuad
    }
  }
}
