const battery = await Service.import('battery')

export default Widget.Box({
  children: [
    Widget.Label({
      label: battery.bind('percent').as(p => `${p}%`),
      class_name: 'label',
    }),
    Widget.Icon({ icon: battery.bind('icon_name'), class_name: 'icon' }),
  ],
  spacing: 6,
  className: 'battery',
})
