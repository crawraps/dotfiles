
<h1 align=center>Crawraps' Widgets Collection</h1>

<div align=center>
  
A customizable collection of widgets built with the [quickshell](https://quickshell.outfoxxed.me/) environment.

</div>

https://github.com/user-attachments/assets/8cd1d3f1-74a7-4dd4-baf0-7fa908daabce

## Table of Contents

- [Installation](#installation)
  - [Manual Installation](#manual-installation)
- [Usage](#usage)
- [Configuration](#configuration)
  - [Appearance Configuration](#appearance-configuration)
  - [Widgets Configuration](#widgets-configuration)
- [Widgets](#widgets)
  - [Dock](#dock)
- [Contributing](#contributing)
- [Future Plans](#future-plans)

## Installation

### Manual Installation

1. **Dependencies:**  
   Install the core dependency - [quickshell](https://quickshell.outfoxxed.me/docs/guide/install-setup/)

   > Some widgets may require additional dependencies for extra features. Read the widget overview before using them.

2. **Clone the Repository:**
   ```sh
   $ git clone https://github.com/crawraps/widgets-collection $HOME/.config/quickshell/cwc
   ```

   > If $XDG_CONFIG_HOME is not defined, use $HOME/.config instead.

## Usage

1. Select the widgets you want to use by editing the `shell.qml` file. Example:
```qml
// shell.qml

...

ShellRoot {
  Dock {} // dock widget with the default configuration
}
```

> Each widget creates an instance for each monitor by default. You can configure this behavior—read the configuration section for details.

2. Start the shell by typing `$ quickshell -c cwc` or `$ quickshell -dc cwc` to run as a daemon.
3. **\*Optional\*** Add the command above to system startup. For example, in Hyprland, add `exec-once=quickshell -dc cwc` to your hyprland.conf.
4. **\*Optional\*** Create an alias for better usability. For example, in zsh, add `alias -- cwc='quickshell -c cwc'` to your .zshrc.

## Configuration

You can configure widgets and their appearance by modifying `.json` files. Every config file supports hot-reload.

### Appearance Configuration

Global appearance (colors, fonts, spacing, etc.) is managed via `appearance.json` in your config directory (e.g., `$HOME/.config/quickshell/cwc/appearance.json`):

```json
{
  "colors": {
    "primary": "#007acc",
    "background": "#20242b"
  },
  "font": {
    "family": { "regular": "Fira Sans" },
    "size": { "xs": 10 }
  },
  "spacing": { "small": 8 },
  "rounding": { "small": 4, "medium": 8 },
  "animation": { "duration": { "normal": 200, "sequential": 50 } },
  "opacity": 0.85
}
```

### Widgets Configuration

Each widget can have several widget-specific `.json` configuration files, each located in the `widgets/[widget-name]/configs/` directory.

When selecting a widget to use, you can provide several common options:

```qml
// shell.qml

...

  Dock {
    name: "power-menu"
    screenIds: [0]
    screens: [Quickshell.screens.reduce((acc, screen) => screen.x > acc.x ? screen : acc, { x: -Infinity })]
  }
```

- **name:** Name of a `.json` configuration file. Default value is `"default"`. In this example, it would be `widgets/dock/configs/power-menu.json`.
- **screenIds:** List of screen IDs where the widget should be displayed. Default: every screen.
- **screens:** List of screens where the widget should be displayed. When this option is present, the **screenIds** option will be ignored. Use this for more precise configuration: in the example above, the widget will be displayed on the rightmost screen.

## Widgets

### Dock

<details>
<summary>Showcase</summary>
  
https://github.com/user-attachments/assets/9c57d09c-0931-4146-995b-eb85c1595df5

https://github.com/user-attachments/assets/5544e0da-eee4-4849-af37-8fa03f177b61
</details>

Each dock can be configured with a JSON file (e.g., `configs/applications.json`):

```json
{
  "position": "bottom",
  "orientation": "horizontal",
  "margins": {
    "right": 200
  },
  "items": [
    "Zen",
    "Obsidian",
    "Thunderbird"
  ],
  "iconSize": 48,
  "alwaysVisible": false,
  "showIconsBackground": true,
  "showTooltips": true,
  "falloff": 3,
  "scaleFactor": 0.3,
  "damp": 1
}
```

- **position:** `"top"`, `"bottom"`, `"left"`, `"right"` - where to position the dock
- **orientation:** `"horizontal"` or `"vertical"` - how to orient the dock
- **margins:** `{ "bottom": number, "top": number, "right": number, "left": number }` - spacing from screen edges. By default, the dock will be centered on the specified **position** edge
- **items:** List of `.desktop` file app names to show; if not defined, all desktop applications will be listed
- **iconSize:** Size of an icon in pixels 
- **alwaysVisible:** If false, the dock expands/collapses on hover
- **showIconsBackground:** Whether to show background for icons
- **showTooltips:** Whether to display tooltips
- **falloff:** Number of items to be affected by hover animation
- **scaleFactor:** Controls item's hover scaling animation strength
- **damp:** Controls nearby items' hover scaling animation strength

## Contributing

If you have new ideas, concepts or implementations, consider contributing to this collection.

There are no guidelines yet, so I would appreciate following the existing architecture with examples of existing widgets.

## Future Plans

Here's a list of widgets I want to create:

- [x] dock
- [ ] launcher
- [ ] translator/dictionary
- [ ] weather display
- [ ] emoji picker
- [ ] mpris
- [ ] system info display
- [ ] feature-rich calendar
