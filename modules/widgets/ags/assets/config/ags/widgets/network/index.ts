const network = await Service.import('network')

const WifiIndicator = () => Widget.Box({
  children: [
    Widget.Label({
      label: network.wifi.bind('ssid').as(ssid => ssid || 'Unknown'),
      className: 'ssid',
    }),
    Widget.Icon({
      icon: network.wifi.bind('icon_name'),
      className: 'icon',
    }),
  ],
  className: 'wifi',
  spacing: 6,
})

const WiredIndicator = () => Widget.Icon({
  icon: network.wired.bind('icon_name'),
})

const NetworkIndicator = () => Widget.Stack({
  children: {
    wifi: WifiIndicator(),
    wired: WiredIndicator(),
  },
  shown: network.bind('primary').as(p => p || 'wifi'),
  className: 'network',
})

export default NetworkIndicator
