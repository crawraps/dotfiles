import NetworkIndicator from 'widgets/network'
import Ram from 'widgets/ram'
import Cpu from 'widgets/cpu'
import KBLayout from 'widgets/kb-layout'
import Backlight from 'widgets/backlight'
import Audio from 'widgets/audio'
import Battery from 'widgets/battery'
import Time from 'widgets/time'
import Workspaces, { gapped } from 'widgets/workspaces'
import Player from 'widgets/player'

interface Props {
  monitor?: number
}

const Left = Widget.Box({
  children: [
    Widget.Box({
      child: Workspaces,
      classNames: ['menu', 'fit'],
    }),
    Widget.Box({
      child: Player,
      classNames: ['menu', 'player'],
    }),
  ],
  className: 'left',
})

const Center = Widget.Box({
  child: Widget.Box({
    children: [Time],
    className: 'menu',
  }),
  className: 'center',
  hpack: 'center',
})

const Right = Widget.Box({
  child: Widget.Box({
    children: [Audio, Backlight, KBLayout, Cpu, Ram, NetworkIndicator, Battery],
    spacing: 20,
    className: 'menu',
  }),
  className: 'right',
  hpack: 'end',
})

const Container = Widget.Box({
  children: [Left, Center, Right],
  homogeneous: true,
  className: 'container gapped',
})

gapped.connect('changed', gapped => Container.toggleClassName('gapped', gapped.value))

export default function Bar({ monitor = 0 }: Props = {}) {
  return Widget.Window({
    name: `top-bar`,
    anchor: ['top', 'left', 'right'],
    child: Container,
    margins: gapped.bind().as(gapped => (gapped ? [4, 4, -4, 8] : [0, 0, 0, 0])),
    layer: 'top',
    exclusivity: 'exclusive',
    className: 'top-bar',
  })
}
