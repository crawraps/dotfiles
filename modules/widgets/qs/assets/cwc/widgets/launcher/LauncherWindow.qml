import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "root:/services"
import "root:/components"
import "root:/utils"
import "root:/utils/scripts/delay.js" as Delay
import "./mapping.js" as Mapping

PanelWindow {
  id: window

  property bool realVisible: false
  Timer { id: timer }

  function getAnchor(pos) { return Boolean(config.data.anchors?.[pos] || config.data.margins?.[pos]) }
  anchors {
    left: getAnchor("left")
    right: getAnchor("right")
    top: getAnchor("top")
    bottom: getAnchor("bottom")
  }

  function getMargin(pos) { return config.data.margins?.[pos] || 0 }
  margins {
    left: getMargin("left")
    right: getMargin("right")
    top: getMargin("top")
    bottom: getMargin("bottom")
  }

  property int defaultHeight: config.data.maxItems * (config.data.itemHeight + appearance.data.spacing.small) + (config.data.itemHeight) + appearance.data.spacing.medium - appearance.data.spacing.small 

  implicitWidth: config.data.width * 3
  implicitHeight: defaultHeight + config.data.itemHeight * 0.5 // 0.1 for OutBack easing

  property var apps: []

  color: "transparent"

  Item {
    id: grid
    width: config.data.width
    height: defaultHeight
    anchors.top: config.data.topToBottom ? parent.top : undefined
    anchors.bottom: config.data.topToBottom ? undefined : parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    Revealer {
      anchors.top: config.data.topToBottom ? parent.top : undefined
      anchors.bottom: config.data.topToBottom ? undefined : parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: config.data.itemHeight
      realVisible: window.realVisible
      delay: 0
      direction: config.data.topToBottom ? "down" : "up"

      SearchBar {
        id: search
        anchors.fill: parent

        debounce: config.data.debounce || 70
        function debouncedTextChanged() {
          this.popupFocused = false
          let apps = Apps.fuzzyQuery(text, config.data.maxItems, entry => !config.data.list?.apps?.exclude?.includes?.(entry.id), 'foot', config.data.favorites)

          if (config.data.autoFocusExtraWhenOneItem && apps.length === 1) popupFocused = true
          window.apps = apps
        }

        Component.onCompleted: {
          debouncedTextChanged()
        }

        property bool popupFocused: false
        Keys.onPressed: ev => Mapping.handleKeyPress(ev)
      }
    }

    ListView {
      id: list
      anchors.top: config.data.topToBottom ? undefined : parent.top
      anchors.bottom: config.data.topToBottom ? parent.bottom : undefined
      anchors.left: parent.left
      anchors.right: parent.right
      height: grid.height - (config.data.itemHeight + appearance.data.spacing.medium)
      spacing: appearance.data.spacing.small
      orientation: Qt.Vertical
      verticalLayoutDirection: config.data.topToBottom ? ListView.TopToBottom : ListView.BottomToTop

      reuseItems: false // add/remove animations don't work with reuseItems

      model: ScriptModel {
        values: window.apps
        onValuesChanged: { list.currentIndex = 0 }
      }

      delegate: Revealer {
        height: config.data.itemHeight
        width: grid.width
        realVisible: window.realVisible
        delay: (index + 1) * appearance.data.animation.duration.sequential
        direction: config.data.topToBottom ? "down" : "up"

        function launch(action) {
          if (modelData.id) UsageTracker.recordLaunch(modelData.id)
          if (action) action.execute()
          else modelData.execute()
        }

        LauncherItem {}

        property alias popup: popupWindow
        ActionsPopup {
          id: popupWindow
          visible: Boolean(modelData.actions?.lenght)
          realVisible: list.currentIndex === index && Boolean(modelData.actions?.length)
          actions: modelData.actions
          opacity: search.popupFocused ? 1 : (config.data.extraUnfocusedOpacity || 1)
        }
      }

      move: Transition {
        NumberAnimation { property: "y"; duration: appearance.data.animation.duration.quick; easing.type: Easing.OutQuad }
      }
      displaced: Transition {
        NumberAnimation { property: "y"; duration: appearance.data.animation.duration.quick; easing.type: Easing.OutBack }
      }
      remove: removeTransition
    }
  }

  onRealVisibleChanged: {
    if (realVisible) {
      window.visible = true
      list.currentIndex = 0
      search.forceActiveFocus()
      onOpenedProcess.running = true
    } else {
      onClosedProcess.running = true
      search.popupFocused = false
      Delay.start(appearance.data.animation.duration.sequential * ((window.apps.length || config.data.maxItems) + 1) + appearance.data.animation.duration.normal, () => {
        window.visible = false
        search.text = ""
      })
    }
  }

  Process {
    id: onOpenedProcess
    command: root.onLauncherOpenedCommand
    running: false
    environment: ({
      SCREEN: window.screenNumber.toString(),
    })
  }

  Process {
    id: onClosedProcess
    command: root.onLauncherClosedCommand
    running: false
    environment: ({
      SCREEN: window.screenNumber.toString(),
    })
  }


  Transition {
    id: removeTransition
    SequentialAnimation {
      NumberAnimation {
        property: "opacity"
        from: 1
        to: 0
        duration: appearance.data.animation.duration.quick
        easing.type: Easing.InQuad
      }
    }
  }

  Transition {
    id: emptyTransition
  }
}
