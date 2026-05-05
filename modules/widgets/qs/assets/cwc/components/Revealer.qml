import QtQuick
import Quickshell

import "root:/utils/scripts/delay.js" as Delay

StyledRect {
  id: root

  property bool realVisible: false

  property int delay: 200
  property string direction: "up"

  state: "Invisible"
  Timer { id: timer }

  property int translation: 0
  property int translationXAbsolute: 0
  property int translationYAbsolute: 0

  transform: Translate {
    x: direction === "left" || direction === "right" ? translation : 0
    y: direction === "up" || direction === "down" ? translation : 0
  }

  states: [
    State {
      name: "Invisible"
      PropertyChanges {
        target: root
        opacity: 0
        translation: direction === "up" ? (0.5 * root.height) : direction === "down" ? (-0.5 * root.height) : direction === "left" ? (0.5 * root.width) : (-0.5 * root.width)
      }
    },

    State {
      name: "Visible"
      PropertyChanges {
        target: root
        opacity: 1
        translation: direction === "up" || direction === "down" ? translationYAbsolute : translationXAbsolute
      }
    }
  ]

  transitions: [
    Transition {
      from: "Invisible"
      to: "Visible"
      NumberAnimation {
        target: root
        properties: "opacity,translation"
        duration: appearance.data.animation.duration.normal
        easing.type: Easing.OutBack
      }
    },

    Transition {
      from: "Visible"
      to: "Invisible"
      NumberAnimation {
        target: root
        properties: "opacity,translation"
        duration: appearance.data.animation.duration.normal
        easing.type: Easing.OutBack
      }
    }
  ]

  Behavior on translationXAbsolute {
    NumberAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.OutBack
    }
  }

  Behavior on translationYAbsolute {
    NumberAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.OutBack
    }
  }

  onRealVisibleChanged: {
    Delay.start(delay, () => {
      root.state = realVisible ? "Visible" : "Invisible";
    })
  }
}
