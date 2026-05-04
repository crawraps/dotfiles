class BrightnessService extends Service {
  // every subclass of GObject.Object has to register itself
  static {
    // takes three arguments
    // the class itself
    // an object defining the signals
    // an object defining its properties
    Service.register(
      this,
      {
        // 'name-of-signal': [type as a string from GObject.TYPE_<type>],
        'screen-changed': ['float'],
      },
      {
        // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
        // 'r' means readable
        // 'w' means writable
        // guess what 'rw' means
        'screen-value': ['float', 'rw'],
      },
    )
  }

  private screenValue = 0
  private max = 100
  private device = ''

  // the getter has to be in snake_case
  get screen_value() {
    return this.screenValue
  }

  // the setter has to be in snake_case too
  set screen_value(percent) {
    if (percent < 0) percent = 0

    if (percent > 100) percent = 100

    Utils.execAsync(`brightnessctl -d ${this.device} -s set ${percent}% -q`)
    // the file monitor will handle the rest
  }

  constructor(device: string) {
    super()

    this.device = device

    this.max = Number(Utils.exec(`brightnessctl -d ${device} max`))

    // setup monitor
    const brightness = `/sys/class/backlight/${this.device}/brightness`
    Utils.monitorFile(brightness, () => this.#onChange())

    // initialize
    this.#onChange()
  }

  #onChange() {
    this.screenValue = Math.round(Number(Utils.exec(`brightnessctl get -d ${this.device}`)) / this.max * 100)

    // signals have to be explicitly emitted
    this.emit('changed') // emits "changed"
    this.notify('screen-value') // emits "notify::screen-value"

    // or use Service.changed(propName: string) which does the above two
    // this.changed('screen-value');

    // emit screen-changed with the percent as a parameter
    this.emit('screen-changed', this.screenValue)
  }

  // overwriting the connect method, let's you
  // change the default event that widgets connect to
  connect(event = 'screen-changed', callback) {
    return super.connect(event, callback)
  }
}

// the singleton instance
const service = new BrightnessService('nvidia_0')

// export to use in other modules
export default service
