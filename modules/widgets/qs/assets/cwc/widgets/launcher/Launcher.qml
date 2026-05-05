import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "root:/utils"
import "root:/components"

Scope {
  id: root
  readonly property string widget: "launcher"
  property string name: "default"

  Config { id: config }
  AppearanceConfig { id: appearance }

  IpcHandler {
    target: `cwc_launcher_${name}`
    function expand(screen: int): void {
      window.screenNumber = screen
      window.realVisible = true
    }
    function collapse(): void {
      window.realVisible = false
    }
    function toggle(screen: int): int {
      if (window.visible) {
        window.realVisible = false
        return 0
      } else {
        window.screenNumber = screen
        window.realVisible = true
        return 1
      }
    }
  }

  property list<string> onLauncherOpenedCommand: []
  property list<string> onLauncherClosedCommand: []

  LauncherWindow {
    id: window
    visible: false
    focusable: window.realVisible
    WlrLayershell.namespace: `cwc_launcher_${name}`
    aboveWindows: true
    exclusionMode: ExclusionMode.Ignore

    property int screenNumber: 0
    screen: Quickshell.screens[screenNumber]
  }
}
