import QtQuick
import Quickshell

import "root:/components"
import "root:/utils/scripts/delay.js" as Delay
import "./mapping.js" as Mapping

Column {
  id: popup
  anchors.left: parent.right
  anchors.leftMargin: appearance.data.spacing.medium
  anchors.top: parent.verticalCenter
  spacing: appearance.data.spacing.small
  width: config.data.width

  property int itemHeight: 0
  height: (itemHeight + spacing) * actions.length - spacing

  property int translation: -itemHeight / 2 - currentIndex * (itemHeight + spacing)
  transform: Translate {
    y: translation
  }

  visible: false
  property bool realVisible: false

  property var actions: []
  property int currentIndex: Math.floor(actions.length / 2 - Math.abs(actions.length % 2 - 1))

  Repeater {
    model: actions

    MouseArea {
      height: actionRevealer.height
      width: actionRevealer.width

      Component.onCompleted: {
        popup.itemHeight = this.height
      }

      Revealer {
        id: actionRevealer
        height: actionName.contentHeight + appearance.data.padding.small * 2
        width: actionName.contentWidth + appearance.data.padding.small * 2
        radius: appearance.data.rounding.small
        color: appearance.getColor("background", true)
        realVisible: popup.realVisible
        delay: {
          const vec = currentIndex - index
          let timing = 0

          if (vec < 0) {
            timing = vec * -2
          } else if (vec > 0) {
            timing = vec * 2 - 1
          }

          return timing * appearance.data.animation.duration.sequential
        }
        direction: "right"

        translationXAbsolute: Math.abs(currentIndex - index) * 10

        StyledText {
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter
          id: actionName
          text: modelData.name
          color: search.popupFocused && currentIndex === index ? appearance.getColor("primary") : appearance.getColor("foreground")
          opacity: search.popupFocused ? 1 : (config.data.extraUnfocusedOpacity || 1)
          font.family: appearance.data.font.family.regular
          font.pointSize: appearance.data.font.size.s

          Behavior on color {
            ColorAnimation {
              duration: appearance.data.animation.duration.quick
              easing.type: Easing.InQuad
            }
          }

          Behavior on opacity {
            NumberAnimation {
              duration: appearance.data.animation.duration.quick
              easing.type: Easing.InQuad
            }
          }
        }
      }
    }
  }

  Behavior on translation {
    NumberAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.OutBack
    }
  }

  Behavior on opacity {
    NumberAnimation {
      duration: appearance.data.animation.duration.quick
      easing.type: Easing.OutQuad
    }
  }

  function handleInput(ev) {
    Mapping.handleActionsPopupKeyPress(ev)
  }

  Timer { id: timer }
  onRealVisibleChanged: {
    if (popup.realVisible) {
      timer.stop()
      popup.visible = true
    } else if (popup.visible) {
      Delay.start(appearance.data.animation.duration.sequential * actions.length + appearance.data.animation.duration.normal, () => {
        search.forceActiveFocus()
        popup.visible = false
      })
    }
  }
}
