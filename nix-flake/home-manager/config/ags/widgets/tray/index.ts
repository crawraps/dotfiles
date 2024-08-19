const systemtray = await Service.import('systemtray')

const SysTrayItem = item =>
  Widget.Button({
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  })

const Tray = Widget.Box({
  children: systemtray.bind('items').as(i => i.map(SysTrayItem)),
})

export default Tray
