import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/components"

Item {
  id: item
  anchors.fill: parent

  property bool showExtraButton: config.data.showExtraButton && Boolean(modelData.actions?.length)
  property bool isFavorite: config.data.favorites && config.data.favorites.indexOf(modelData.id) !== -1
  property bool showFavoriteIndicator: isFavorite && config.data.showFavoriteIndicator

  property real pseudoScale: {
    const falloff = config.data.falloff || 3
    let diff = Math.abs(index - list.currentIndex)
    diff = Math.max(0, falloff - diff)
    let damp = falloff - Math.max(1, diff)
    let sc = config.data.scaleFactor
    if (damp) sc /= damp * (config.data.damp || 1)
    diff = diff / falloff * sc
    return diff
  }

  MouseArea {
    z: 1
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    onEntered: list.currentIndex = index
    onClicked: {
      window.realVisible = false
      list.currentItem.launch()
    }
  }

  RowLayout {
    anchors.fill: parent
    spacing: appearance.data.spacing.small

    StyledRect {
      Layout.fillHeight: true
      color: appearance.getColor("background", true)
      topLeftRadius: appearance.data.rounding.medium
      bottomLeftRadius: appearance.data.rounding.medium
      topRightRadius: appearance.data.rounding.small
      bottomRightRadius: appearance.data.rounding.small

      Layout.preferredWidth: (item.pseudoScale + 1) * config.data.itemHeight

      StyledRect {
        visible: config.data.colorfull
        anchors.fill: parent
        color: appearance.getColor("primary")
        topLeftRadius: appearance.data.rounding.medium
        bottomLeftRadius: appearance.data.rounding.medium
        topRightRadius: appearance.data.rounding.small
        bottomRightRadius: appearance.data.rounding.small
        opacity: item.pseudoScale * (appearance.data.opacity / 1.5)

        Behavior on opacity {
          NumberAnimation {
            duration: appearance.data.animation.duration.normal
            easing.type: Easing.InQuad
          }
        }
      }

      Image {
        height: parent.height
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        source: Quickshell.iconPath(modelData.icon)
        fillMode: Image.PreserveAspectFit
      }

      Behavior on Layout.preferredWidth {
        NumberAnimation {
          duration: appearance.data.animation.duration.normal
          easing.type: Easing.OutBack
        }
      }
    }

    StyledRect {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: appearance.getColor("background", true)
      clip: true
      topRightRadius: item.showExtraButton ? appearance.data.rounding.small : appearance.data.rounding.medium
      bottomRightRadius: item.showExtraButton ? appearance.data.rounding.small : appearance.data.rounding.medium
      topLeftRadius: appearance.data.rounding.small
      bottomLeftRadius: appearance.data.rounding.small

      Rectangle {
        id: gradientRect
        visible: config.data.colorfull
        anchors.fill: parent
        radius: appearance.data.rounding.medium
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0
            color: appearance.getColor("primary", true)
          }
          GradientStop {
            position: 0.5
            color: "transparent"
          }
        }
        transform: Translate {
          x: (-1 + item.pseudoScale) * parent.width / 2

          Behavior on x {
            NumberAnimation {
              duration: appearance.data.animation.duration.normal
              easing.type: Easing.InQuad
            }
          }
        }
      }

      Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: favStar.visible ? favStar.left : parent.right
        leftPadding: appearance.data.padding.medium

        StyledText {
          text: modelData.name
          color: appearance.getColor("foreground")
          font.pointSize: appearance.data.font.size.m
          font.family: appearance.data.font.family.regular
        }

        StyledText {
          visible: config.data.showSubtitle
          text: modelData.comment
          color: appearance.getColor("foreground", .7)
          font.pointSize: appearance.data.font.size.s
          font.family: appearance.data.font.family.regular
        }
      }

      Icon {
        id: favStar
        visible: item.showFavoriteIndicator
        anchors.right: parent.right
        anchors.rightMargin: appearance.data.padding.medium
        anchors.verticalCenter: parent.verticalCenter
        text: ""
        fill: 1
        color: appearance.getColor("primary")

        property bool realVisible: list.currentIndex === index

        opacity: realVisible ? 1 : 0
        scale: realVisible ? 1 : 0.4

        Behavior on opacity {
          NumberAnimation {
            duration: appearance.data.animation.duration.normal
            easing.type: Easing.OutQuad
          }
        }

        Behavior on scale {
          NumberAnimation {
            duration: appearance.data.animation.duration.normal
            easing.type: Easing.OutBack
          }
        }
      }
    }

    StyledRect {
      visible: item.showExtraButton
      Layout.fillHeight: true
      Layout.preferredWidth: config.data.itemHeight * .75
      color: appearance.getColor("background", true)
      topLeftRadius: appearance.data.rounding.small
      bottomLeftRadius: appearance.data.rounding.small
      topRightRadius: appearance.data.rounding.medium
      bottomRightRadius: appearance.data.rounding.medium

      Icon {
        anchors.centerIn: parent
        text: ""
        color: list.currentIndex === index ? appearance.getColor("primary") : appearance.getColor("foreground")

        Behavior on color {
          ColorAnimation {
            duration: appearance.data.animation.duration.quick
            easing.type: Easing.InQuad
          }
        }
      }
    }
  }
}
