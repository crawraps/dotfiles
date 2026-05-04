const audio = await Service.import('audio')

export const audioIcons: [number, string][] = [
  [81, 'high'],
  [34, 'medium'],
  [1, 'low'],
  [0, 'muted'],
]

const Indicator = () => Widget.Box({
  children: [
    Widget.Label({
      label: audio.speaker.bind('volume').as(value => Math.round(value * 100).toString() + '%'),
    }),
    Widget.Icon({
      className: 'icon',
    }).hook(audio.speaker, self => {
      const vol = audio.speaker.volume * 100
      const icon = audio.speaker.is_muted ? 'muted' : audioIcons.find(([threshold]) => threshold <= vol)?.[1]

      self.icon = `volume-${icon}`
      self.tooltip_text = `Volume ${Math.floor(vol)}%`
    }),
  ],
  className: 'audio-indicator',
  spacing: 6,
})

export default () => Widget.Button({
  on_clicked: () => (audio.speaker.is_muted = !audio.speaker.is_muted),
  child: Indicator(),
  className: 'audio',
})
