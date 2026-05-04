export interface Playback {
  status: 'Playing' | 'Paused'
  artist: string
  title: string
}

const defaultPlayback: Playback = {
  status: 'Paused',
  artist: '',
  title: '',
}

export const currentPlayback = Variable(defaultPlayback, {
  listen: [
    `playerctl metadata -f '{"status": "{{ status }}", "artist": "{{ artist }}", "title": "{{ title }}"}' --follow`,
    out => JSON.parse(out),
  ],
})

export default () => Widget.EventBox({
  child: Widget.Box({
    children: [
      Widget.Icon({
        icon: 'music-note',
        className: 'icon',
      }),
      Widget.Revealer({
        child: Widget.Label({
          label: currentPlayback.bind().as(playback => `${playback.artist} - ${playback.title}`),
          maxWidthChars: 50,
          truncate: 'end',
        }),
        revealChild: currentPlayback.bind().as(playback => playback.status === 'Playing'),
        transition: 'slide_right',
        className: 'title',
      }),
    ],
    className: 'playback',
  }),
  cursor: 'pointer',
  onPrimaryClick: () => {
    Utils.execAsync('playerctl play-pause')
  }
})
