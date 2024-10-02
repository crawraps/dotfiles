function getUsage(out: string) {
  const usage = out
    .split('\n')
    .find(line => line.includes('Cpu(s)'))
    ?.split(/\s+/)[1]
    ?.replace(',', '.')

  return Number(usage)
}

export const cpu = Variable('0', {
  poll: [5000, 'top -bn1', out => `${getUsage(out).toFixed(2)}%`],
})

export default () => Widget.Box({
  children: [
    Widget.Label({
      label: cpu.bind(),
      className: 'usage',
    }),
    Widget.Icon({
      icon: 'cpu',
      className: 'icon',
    }),
  ],
  className: 'cpu',
  spacing: 6,
})
