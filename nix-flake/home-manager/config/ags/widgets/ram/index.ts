function getGib(freeOutput: string) {
  const free = freeOutput
    .split('\n')
    .find(line => line.includes('Mem:'))
    ?.split(/\s+/)?.[2]

  return (Number(free) / 1024 / 1024)
}

export const ram = Variable<string>('0 ram', {
  poll: [5000, 'free', out => `${getGib(out).toFixed(2)}Gib`],
})

export default Widget.Box({
  children: [
    Widget.Label({
      label: ram.bind(),
      className: 'ram',
    }),
    Widget.Icon({
      icon: 'ram',
      className: 'icon',
    }),
  ],
  className: 'ram',
  spacing: 6,
})
