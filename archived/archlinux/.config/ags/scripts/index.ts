import TopBar from 'windows/topbar'
import Sliders from 'windows/sliders'
import PowerMenu from 'windows/power-menu'

App.config({
  windows: [TopBar(), Sliders(), PowerMenu()],
  style: loadStyles(),
})

App.addIcons(`${App.configDir}/assets/icons`)
App.closeWindow('sliders')
App.closeWindow('power-menu')

App.closeWindowDelay = {
  'sliders': 200,
}

function loadStyles(): string {
  const styles = `${App.configDir}/styles/index.scss`
  const resolvedStyles = `/home/careem/.cache/ags/styles/index.css`

  Utils.exec(`sassc ${styles} ${resolvedStyles}`)

  return resolvedStyles
}
