import { IconProps } from 'types/widgets/icon'
import { SliderProps } from 'types/widgets/slider'

interface Props<T> extends SliderProps<T> {
  vertical?: boolean
  iconProps?: IconProps
}

interface Attrib {
  icon?: string
  disabled?: boolean
}

export default function Slider<T>({ vertical = false, iconProps, ...props }: Props<T>) {
  return Widget.Box<any, Attrib>({
    className: 'slider-wrapper',
    attribute: {
      icon: '',
      disabled: false,
    },
    children: [
      Widget.Slider<T>({
        className: 'slider',
        vexpand: vertical,
        hexpand: !vertical,
        orientation: vertical ? 1 : 0,
        inverted: vertical,
        showFillLevel: false,
        step: 0.01,
        drawValue: false,
        ...props,
      }),
      Widget.Icon({
        className: 'icon',
        size: 18,
        ...iconProps,
      }),
    ],
    orientation: vertical ? 1 : 0,
    spacing: 4,
    setup(self) {
      self.on('notify::attribute', () => {
        self.children[1].icon = self.attribute.icon
        self.toggleClassName('disabled', self.attribute.disabled)
      })
    },
  })
}
