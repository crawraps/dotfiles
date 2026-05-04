import brightness from 'scripts/backlight'

export const brightnessIcons = new Array(5).fill(0).map((_, i) => `backlight-${i + 1}`)

export default () => Widget.Box({
  children: [
    Widget.Label({
      label: brightness.bind('screen_value').as(v => `${v}%`),
    }),
    Widget.Icon({
      icon: brightness.bind('screen_value').as(v => brightnessIcons[Math.floor(v / (100 / brightnessIcons.length))]),
      className: 'icon'
    }),
  ],
  spacing: 6,
  className: 'backlight'
})
