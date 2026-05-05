import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/utils"
import "root:/components"

Rectangle {
  id: item

  property int length: config.data.iconSize * pseudoScale + appearance.data.spacing.medium + (config.data.alwaysVisible ? (config.data.iconSize + appearance.data.spacing.small) : additionalHeight)
  property int breadth: config.data.iconSize + appearance.data.spacing.medium

  width: config.data.orientation == "vertical" ? length : breadth
  height: config.data.orientation == "vertical" ? breadth : length

  color: "transparent"

  Timer {
    id: timer
  }

  function delay(height, latestIndex = row.current) {
    timer.interval = Math.abs(index - latestIndex) * appearance.data.animation.duration.sequential
    timer.repeat = false
    timer.triggered.connect(() => additionalHeight = height)
    timer.start()
  }

  property int additionalHeight: 0
  property real pseudoScale: {
    if (row.current == -1) return 0
    else {
      const falloff = config.data.falloff || 3
      let diff = Math.abs(index - row.current)
      diff = Math.max(0, falloff - diff)
      let damp = falloff - Math.max(1, diff)
      let sc = config.data.scaleFactor
      if (damp) sc /= damp * (config.data.damp || 1)
      diff = diff / falloff * sc
      return diff
    }
  }

  MouseArea {
    id: itemMouseArea
    anchors.fill: parent
    hoverEnabled: true
    onEntered: { row.current = index; if (!config.data.alwaysVisible && !expandedByIPC) { window.expand() } }
    onExited: { if (row.current == index) { row.current = -1; if (!config.data.alwaysVisible && !expandedByIPC) { window.collapse(index) } } }
    onClicked: modelData.execute()
    cursorShape: Qt.PointingHandCursor
    propagateComposedEvents: true

    Tooltip {
      visible: config.data.showTooltips ? parent.containsMouse : false
    }

    Column {
      anchors.top: config.data.position == "bottom" ? parent.top : undefined
      anchors.right: config.data.position == "left" ? parent.right : undefined
      anchors.bottom: config.data.position == "top" ? parent.bottom : undefined
      anchors.left: config.data.position == "right" ? parent.left : undefined

      anchors.horizontalCenter: config.data.orientation == "horizontal" ? parent.horizontalCenter : undefined
      anchors.verticalCenter: config.data.orientation == "vertical" ? parent.verticalCenter : undefined

      topPadding: config.data.position == "bottom" ? appearance.data.spacing.medium : undefined
      rightPadding: config.data.position == "left" ? appearance.data.spacing.medium : undefined
      bottomPadding: config.data.position == "top" ? appearance.data.spacing.medium : undefined
      leftPadding: config.data.position == "right" ? appearance.data.spacing.medium : undefined

      width: config.data.orientation == "vertical" ? item.length : config.data.iconSize
      height: config.data.orientation == "vertical" ? config.data.iconSize : item.length

      Rectangle {
        width: config.data.iconSize
        height: width

        color: config.data.showIconsBackground ? appearance.getColor("background", true) : "transparent"
        radius: appearance.data.rounding.medium
        border.color: appearance.getColor("primary")
        border.width: itemMouseArea.containsPress ? 1 : 0

        Image {
          width: parent.width
          height: width
          source: Quickshell.iconPath(modelData.icon)

          transform: Scale {
            origin.x: config.data.iconSize / 2
            origin.y: config.data.iconSize / 2
            xScale: itemMouseArea.containsPress ? 0.9 : 1
            yScale: itemMouseArea.containsPress ? 0.9 : 1
          }
        }
      }
    }
  }

  Behavior on length {
    NumberAnimation {
      duration: appearance.data.animation.duration.normal
      easing.type: Easing.OutBack
    }
  }
}
