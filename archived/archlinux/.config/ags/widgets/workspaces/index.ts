const hyprland = await Service.import('hyprland')

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

const Container = Widget.Box({
  children: Array.from({ length: 10 }, (_, i) => i + 1).map(i =>
    Widget.Button({
      attribute: i,
      label: `${i}`,
      onPrimaryClick: () => dispatch(i),
      className: 'workspace',
    }),
  ),

  setup: self => {
    self.hook(hyprland, () => {
      self.children.forEach(btn => {
        btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute)
      })
    })

    self.hook(hyprland.active.workspace, () => {
      self.children.forEach(btn => {
        btn.toggleClassName('active', btn.attribute === hyprland.active.workspace.id)
      })
    })
  },
  className: 'inner-container',
})

export default Widget.EventBox({
  onScrollUp: () => dispatch('+1'),
  onScrollDown: () => dispatch('-1'),
  child: Container,
  className: 'workspaces',
})

export const gapped = Variable(true)
hyprland.connect('event', (_, name: string) => {
  switch (name) {
    case 'workspace':
    case 'destroyworkspace':
    case 'openwindow':
    case 'closewindow':
      const activeWorkspace = hyprland.active.workspace.id
      const windows = hyprland.workspaces.find(ws => ws.id === activeWorkspace)?.windows

      gapped.value = windows !== 1

      break
  }
})
