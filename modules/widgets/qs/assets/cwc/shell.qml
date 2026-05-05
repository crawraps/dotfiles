import Quickshell

import "widgets/dock" as Dock
import "widgets/launcher" as Launcher

ShellRoot {
  Dock.Dock { name: "applications" }
  Dock.Dock {
    name: "power-menu"
    screens: [Quickshell.screens.reduce((acc, screen) => screen.x > acc.x ? screen : acc, { x: -Infinity })] // Only use the rightmost screen for the power menu
  }

  Launcher.Launcher {
    name: "local"
    onLauncherOpenedCommand: ["sh", "-c", "qs -c cwc ipc call cwc_dock_applications expand $SCREEN"]
    onLauncherClosedCommand: ["sh", "-c", "qs -c cwc ipc call cwc_dock_applications collapse $SCREEN"]
  }
}
