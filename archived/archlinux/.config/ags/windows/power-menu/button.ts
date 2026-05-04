export interface PowerMenuButtonProp {
  label: string
  icon?: string
  command: string
}

export default function PowerMenuButton(props: PowerMenuButtonProp) {
  const key = props.label.match(/[A-Z]/g)?.[0] ?? ''
  const label = {
    key,
    firstChunk: props.label.split(key)[0][0]?.toUpperCase() ?? '' + props.label.split(key)[0]?.slice(1) ?? '',
    secondChunk: props.label.split(key)?.slice(1)?.join('') ?? '',
  }

  if (label.firstChunk) {
    label.key = label.key.toLowerCase()
  }

  return Widget.Button({
    className: 'button',
    onClicked: () => {
      Utils.execAsync(props.command)
    },
    child: Widget.Box({
      className: 'box',
      children: [
        Widget.Icon({
          className: 'icon',
          icon: props.icon,
          size: 100,
        }),
        Widget.Box({
          className: 'label',
          children: [
            Widget.Label({
              label: label.firstChunk,
            }),
            Widget.Label({
              className: 'key',
              label: label.key,
            }),
            Widget.Label({
              label: label.secondChunk,
            }),
          ],
          spacing: 1,
          hpack: 'center',
        }),
      ],
      vpack: 'center',
      hpack: 'fill',
      orientation: 1,
      spacing: 6,
    }),
    cursor: 'pointer',
    widthRequest: 200,
    heightRequest: 200,
  })
}
