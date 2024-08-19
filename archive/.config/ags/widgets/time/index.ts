export const currentTime = Variable<Date>(new Date(), {
  poll: [1000, () => new Date(Utils.exec('date +"%Y-%m-%dT%H:%M:%S%z"'))],
})

const revealed = Variable(false)

export default Widget.EventBox({
  child: Widget.Box({
    children: [
      Widget.Label({
        label: currentTime.bind().as(date =>
          date
            .toLocaleTimeString('en-US', {
              hour12: true,
              hour: '2-digit',
              minute: '2-digit',
            })
            .replace(/(A|P)M/g, '')
            .trim(),
        ),
      }),
      Widget.Revealer({
        child: Widget.Label({
          label: currentTime.bind().as(date => '| ' + date.toLocaleDateString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
          })),
        }),
        revealChild: revealed.bind(),
        transition: 'slide_right',
        className: 'date'
      }),
    ],
    className: 'time',
  }),
  onHover: () => {
    revealed.value = true
  },
  onHoverLost: () => {
    revealed.value = false
  }
})
