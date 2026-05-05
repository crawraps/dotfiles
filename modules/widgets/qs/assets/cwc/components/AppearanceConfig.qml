import "root:/utils"

Config {
  name: "appearance"
  topLevel: true

  function getColor(color, alpha = 1) {
    if (alpha === true) {
      alpha = data.opacity
    }

    if (alpha === 1) {
      return data.colors[color]
    }

    return `#${alpha * 100}${data.colors[color].slice(1)}`
  }
}
