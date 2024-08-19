const hyprland = await Service.import('hyprland')

enum Layout {
  en = 'en',
  ru = 'ru',
}

const layout = Variable<Layout>(Layout.en)

hyprland.connect('keyboard_layout', (_, __, lay: string) => layout.value = lay.toLowerCase().slice(0, 2) as Layout)

export default Widget.Box({
  child: Widget.Label({
    label: layout.bind(),
  }),
})
