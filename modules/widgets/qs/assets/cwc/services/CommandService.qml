pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  readonly property string windowTitle: "CWC-Launcher-Terminal"

  Process {
    id: terminalProcess
    running: false
  }

  function getTitleFlag(term) {
    if (term === "foot") return "-T"
    return "--title"
  }

  function runInTerminal(userCommand, terminalEmulator) {
    const term = terminalEmulator || "foot"
    const titleFlag = getTitleFlag(term)
    const shellCmd = `${userCommand}; echo; echo "Process finished. Press Enter to close..."; read`

    terminalProcess.command = [term, titleFlag, root.windowTitle, "sh", "-c", shellCmd]
    terminalProcess.running = true
  }
}
