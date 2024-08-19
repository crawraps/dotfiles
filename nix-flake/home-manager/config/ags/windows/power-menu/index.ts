import PowerMenuButton, { PowerMenuButtonProp } from './button'

const hyprland = await Service.import('hyprland')

const buttons: PowerMenuButtonProp[] = [
  {
    label: 'Shutdown',
    icon: 'poweroff',
    command: 'poweroff',
  },
  {
    label: 'Restart',
    icon: 'restart',
    command: 'reboot',
  },
  {
    label: 'Logout',
    icon: 'logout',
    command: 'hyprctl dispatch exit && loginctl --kill-user `whoami`',
  },
  {
    label: 'lOck',
    icon: 'lock',
    command: 'lock',
  },
]

interface Props {
  monitor?: number
}

const Container = Widget.Box({
  className: 'container',
  children: buttons.map(PowerMenuButton),
  vpack: 'center',
  hpack: 'center',
  spacing: 50,
})

export default function Bars({ monitor = 0 }: Props = {}) {
  return Widget.Window({
    name: `power-menu`,
    anchor: ['top', 'right', 'bottom', 'left'],
    className: 'power-menu',
    child: Container,
    layer: 'overlay',
    margins: [-40, 0, 0, 0],
  })
}

hyprland.connect('submap', (_, name: string) => {
  if (name === 'power-menu') {
    App.openWindow('power-menu')
  } else if (name === '') {
    App.closeWindow('power-menu')
  }
})
