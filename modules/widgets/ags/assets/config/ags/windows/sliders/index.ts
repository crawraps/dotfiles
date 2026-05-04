import { Variable as VariableType } from 'types/variable'
import Slider from 'widgets/slider'
import brightness from 'scripts/backlight'
import { audioIcons } from 'widgets/audio'
import { brightnessIcons } from 'widgets/backlight'
import GLib from 'types/@girs/glib-2.0/glib-2.0'

const audio = await Service.import('audio')

interface Props {
  monitor?: number
}

const changeHandler = (revealed: VariableType<boolean>, timeout: GLib.Source | null) => {
  revealed.value = true
  timeout?.destroy?.()

  return setTimeout(() => {
    revealed.value = false
  }, 3000)
}

const brightnessHovered = Variable(false)
const brightnessChanged = Variable(false)
let brightnessTimeout: GLib.Source | null = null
brightness.connect('changed', () => {
  brightnessTimeout = changeHandler(brightnessChanged, brightnessTimeout)
})

const brightnessRevealed = Utils.merge<boolean, any, any>([brightnessChanged.bind(), brightnessHovered.bind()], (a, b) => a || b)

const audioHovered = Variable(false)
const audioChanged = Variable(false)
let audioTimeout: GLib.Source | null = null
audio.connect('speaker-changed', () => {
  audioTimeout = changeHandler(audioChanged, audioTimeout)
})

const audioRevealed = Utils.merge<boolean, any, any>([audioChanged.bind(), audioHovered.bind()], (a, b) => a || b)

Utils.merge<boolean, any, any>([brightnessRevealed, audioRevealed], (a, b) => a || b).emitter.connect('changed', ({ value }) => {
  if (value) {
    App.openWindow('sliders')
  } else {
    App.closeWindow('sliders')
  }
})

const BrightnessSlider = Widget.EventBox({
  className: 'brightness-slider',
  child: Widget.Revealer({
    child: Slider({
      value: brightness.bind('screen_value'),
      onChange: ({ value }) => (brightness.screen_value = value),
      vertical: true,
      min: 0,
      max: 100,
      step: 1,
      digits: 0,
      iconProps: {
        size: 18,
        margin: 3,
      },
    }).hook(brightness, self => {
      self.attribute = {
        icon: brightnessIcons[Math.floor(brightness.screen_value / (100 / brightnessIcons.length))],
        disabled: false,
      }
    }),
    revealChild: brightnessRevealed,
    transition: 'slide_left',
  }),
  vpack: 'end',
  heightRequest: 300,
  onHover: () => {
    brightnessHovered.value = true
  },
  onHoverLost: () => {
    brightnessHovered.value = false
  },
})

const AudioSlider = Widget.EventBox({
  className: 'audio-slider',
  child: Widget.Revealer({
    child: Slider({
      value: audio.speaker.bind('volume').as(volume => Math.round(volume * 100)),
      onChange: ({ value }) => (audio.speaker.volume = value / 100),
      vertical: true,
      min: 0,
      max: 100,
      step: 1,
      digits: 0,
      iconProps: {
        size: 24,
      },
    }).hook(audio.speaker, self => {
      const vol = audio.speaker.volume * 100
      const icon = audio.speaker.is_muted ? 'muted' : audioIcons.find(([threshold]) => threshold <= vol)?.[1]

      self.attribute = {
        icon: `volume-${icon}`,
        disabled: audio.speaker.is_muted ?? false,
      }
    }),
    revealChild: audioRevealed,
    transition: 'slide_left',
  }),
  onHover: () => {
    audioHovered.value = true
  },
  onHoverLost: () => {
    audioHovered.value = false
  },
})

export default function Bars({ monitor = 0 }: Props = {}) {
  return Widget.Window({
    name: `sliders`,
    anchor: ['right', 'top'],
    heightRequest: 400,
    layer: 'overlay',
    margins: [150, 0, 0, 0],
    visible: false,
    child: Widget.Box({
      children: [BrightnessSlider, AudioSlider],
      spacing: 6,
      margin: 6,
    }),
  })
}
