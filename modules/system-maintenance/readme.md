# system-maintenance

system upkeep services with optional btop TUI.

**Preference key:** `preferences.modules.system-maintenance`
**Default:** `{ tui = true; }`

Accepts `true` or an attrs with `tui` sub-flag.

**Files:**
- `system.nix` — enables fstrim, upower (low/critical battery thresholds), tlp (performance/power profiles, battery charge thresholds), nix gc (weekly, 30-day retention)
- `home.nix` — enables btop when `{ tui = true; }`

**Dependencies:** none