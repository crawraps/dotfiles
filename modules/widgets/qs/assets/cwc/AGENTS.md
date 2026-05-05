# CLAUDE.md — Crawraps' Widgets Collection (cwc)

Use context7 mcp to get qml and quickshell latest documentations.

A customizable collection of desktop shell widgets built with [Quickshell](https://quickshell.outfoxxed.me/) (Qt6/QML).

## Project Structure

```
shell.qml                          # Entry point — declares all active widgets
components/                        # Reusable UI components
widgets/{widget}/                  # Full widget implementations
configs/                           # JSON config files (hot-reloadable)
configs/appearance.json            # Global appearance (colors, fonts, spacing, animation)
configs/{widget}/                  # Per-widget config variants
services/                          # Singleton services (Apps)
utils/                             # Utilities (Config, Paths)
utils/scripts/                     # JavaScript helpers (delay, fuzzysort)
```

### Widgets

Each widget follows this structure:
- **Root file** (e.g., `Dock.qml`) — `Scope` with IPC handler and `Variants` for multi-screen support
- **Window file** (e.g., `DockWindow.qml`) — `PanelWindow` with layout and rendering
- **Item file** (e.g., `DockItem.qml`) — individual item component
- Config variants in `configs/{widget}/`

Current widgets: **Dock**, **Launcher**

### Configuration

- All config is JSON-based and loaded via `Config.qml` (a `FileView` wrapper with `watchChanges: true`)
- Global appearance: `configs/appearance.json`
- Widget configs: `configs/{widget}/{name}.json`
- Changes to `.json` files are picked up automatically at runtime (hot-reload)

## QML Coding Conventions

### Imports

```qml
import QtQuick                         // Qt modules first
import Quickshell                      // Quickshell modules second
import Quickshell.Io
import "root:/utils"                   // Project imports last, always use "root:/" prefix
import "root:/components"
import "root:/utils/scripts/delay.js" as Delay
```

Always use `"root:/"` prefix for project-internal imports. Never use relative paths like `"../../utils"`.

### Component Structure

```qml
Scope {
  id: root

  // 1. Required widget metadata
  readonly property string widget: "widgetName"
  property string name: "default"

  // 2. Config and appearance
  Config { id: config }
  AppearanceConfig { id: appearance }

  // 3. Properties (readonly first, then mutable, then computed)
  // 4. IPC handler
  // 5. Variants / child components
}
```

### Naming

- **Files:** PascalCase (e.g., `DockItem.qml`, `AppearanceConfig.qml`)
- **Component IDs:** lowercase short names (`id: root`, `id: dock`, `id: config`)
- **Properties:** camelCase
- **IPC handler targets:** `cwc_{widget}_{name}` (e.g., `cwc_dock_applications`)
- **WlrLayershell namespace:** `cwc_{widget}_{name}`

### Appearance Access

Use the centralized appearance system, never hardcode colors/sizes:

```qml
appearance.getColor("background")       // Color without alpha
appearance.getColor("primary", true)    // Color with global opacity as alpha
appearance.getColor("foreground", 0.5)  // Color with explicit alpha

appearance.data.spacing.{small|medium|large}
appearance.data.padding.{small|medium|large}
appearance.data.rounding.{small|medium|large}
appearance.data.font.family.{regular|heading|icons}
appearance.data.font.size.{xs|s|m|l|xl|xxl|icon}
appearance.data.animation.duration.{quick|normal|slow|sequential}
```

### Animation Patterns

- Color transitions: `ColorAnimation` with `Easing.InQuad`, duration from `appearance.data.animation.duration`
- Hover effects: staggered scaling based on distance from cursor using `falloff`, `scaleFactor`, `damp` config
- Sequential/cascade animations: `index * appearance.data.animation.duration.sequential`
- Reveal animations: `Easing.OutBack` for pop-in effects
- Layout transitions: `NumberAnimation` on property changes via `Behavior`

### Services

Services are `pragma Singleton` files in `services/`. Access them via import:
- `Apps.qml` — application list with fuzzy search (`Apps.fuzzyQuery(search, max, filter)`)

### Multi-Screen Support

Use the `Variants` component with `Quickshell.screens` as model to create per-screen widget instances. Widgets can optionally accept a `screens` property to limit which screens they appear on.

## Running

```bash
quickshell -c cwc-dev              # Run the shell
quickshell -dc cwc-dev             # Run as daemon
qs -c cwc-dev ipc call <target> <command> [args]  # IPC control
```

## Key Rules

- Never hardcode visual values — always reference `appearance.data`
- Always use `"root:/"` imports for project files
- Every widget must have `widget` and `name` properties
- Every widget must have an `IpcHandler` for external control
- Config files are JSON only — keep them flat and simple
- Components go in `components/`, widgets in `widgets/`
- Use `Scope` as root element for widgets (not `Item` or `Rectangle`)
- Use `PanelWindow` for widget windows with `WlrLayershell` namespace
- Set `exclusionMode: ExclusionMode.Ignore` on panel windows
- Prefer `FileView` with `watchChanges` for any file that should hot-reload
