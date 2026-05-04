# bluetooth

bluetooth hardware support with optional TUI manager.

**Preference key:** `preferences.modules.bluetooth`
**Default:** `{ tui = true; }`

Accepts `true` or an attrs with `tui` sub-flag.

**Files:**
- `system.nix` — enables bluetooth hardware, blueman, experimental features
- `home.nix` — installs `bluetui` when `{ tui = true; }`
- `assets/` — bluetooth-related assets

**Dependencies:** none