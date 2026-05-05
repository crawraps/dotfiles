pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  // map of { appId: launchCount }
  property var scores: ({})

  readonly property string filePath: Quickshell.cachePath("launcher_scores.json")

  FileView {
    id: file
    path: root.filePath
    blockLoading: true
    watchChanges: true
    atomicWrites: true
    printErrors: false
    onFileChanged: reload()
    onLoaded: {
      try {
        const text = file.text()
        root.scores = text ? JSON.parse(text) : ({})
      } catch (e) {
        root.scores = ({})
      }
    }
    onLoadFailed: {
      root.scores = ({})
      // create the file so future writes have a target
      file.setText("{}")
    }
  }

  function getScore(appId: string): int {
    if (!appId) return 0
    return root.scores[appId] || 0
  }

  function recordLaunch(appId: string): void {
    if (!appId) return
    const next = Object.assign({}, root.scores)
    next[appId] = (next[appId] || 0) + 1
    root.scores = next
    file.setText(JSON.stringify(next))
  }

  function reset(): void {
    root.scores = ({})
    file.setText("{}")
  }
}
