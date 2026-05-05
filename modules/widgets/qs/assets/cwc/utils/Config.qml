import Quickshell.Io

FileView {
  id: config
  blockLoading: true
  watchChanges: true
  onFileChanged: reload()

  property string name: root.name || "default"
  property bool topLevel: name === "appearance"

  path: {
    if (topLevel) {
      return `${Paths.root}/configs/${name}.json`
    } else {
      return `${Paths.root}/configs/${widget}/${name}.json`
    }
  }

  readonly property var data: JSON.parse(config.text())
}
