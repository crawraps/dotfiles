import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "root:/utils"
import "root:/components"

Scope {
  id: root
  readonly property string widget: "dock"
  property string name: "default"

  Config { id: config }
  AppearanceConfig { id: appearance }

  property list<int> screenIds: Quickshell.screens.map((_, i) => i)
  property list<ShellScreen> screens: Quickshell.screens.filter((_, i) => screenIds.includes(i))

  IpcHandler {
    target: `cwc_dock_${name}`
    function expand(screen: int): void {
      variants.instances.forEach((inst, ind) => {
        if (ind === screen || screen === -1) {
          inst.expand(inst.apps.length / 2)
          inst.expandedByIPC = true
        }
      })
    }
    function collapse(screen: int): void {
      variants.instances.forEach((inst, ind) => {
        if (ind === screen || screen === -1) {
          inst.collapse(inst.apps.length / 2)
          inst.expandedByIPC = false
        }
      })
    }
  }

  Variants {
    id: variants
    model: screens

    DockWindow {
      WlrLayershell.namespace: `cwc_dock_${name}`
      aboveWindows: true
      exclusionMode: ExclusionMode.Ignore
    }
  }
}
