const WINDOW_NAME = 'run'

interface LauncherProps {
  width: number
}

function Launcher({ width }: LauncherProps) {
  const query = Variable('')

  const entry = Widget.Entry({
    className: 'input',
    widthRequest: width,
    onChange: entry => {
      query.value = entry.text ?? ''
    },
  })

  const output = Widget.Revealer({
    className: 'output-revealer',
    transition: 'slide_up',
    transitionDuration: 200,
    child: Widget.Box({
      className: 'output-box',
      children: [],
    }),
  })

  return Widget.Box({
    className: 'run',
    vertical: true,
    children: [
      output,
      Widget.Box({
        className: 'input-box',
        children: [entry],
      }),
    ],
    setup: self =>
      self.hook(App, (_, windowName, visible) => {
        if (windowName !== WINDOW_NAME) return

        // when the applauncher shows up
        if (visible) {
          entry.text = ''
          entry.grab_focus()
        }
      }),
  })
}

export default function Run(monitor = 0) {
  return Widget.Window({
    monitor: monitor,
    name: WINDOW_NAME,
    className: 'run',
    anchor: ['bottom'],
    layer: 'overlay',
    visible: false,
    keymode: 'exclusive',
    child: Launcher({ width: 450 }),
    setup: self =>
      self.keybind('Escape', () => {
        App.closeWindow(WINDOW_NAME)
      }),
  })
}
