# widgets / qs

quickshell panel with cwc (custom widget collection) configuration.

**Preference key:** `preferences.modules.widgets.qs`
**Default:** `true`

**Files:**
- `home.nix` — installs quickshell, `toggle-launcher` script, cwc quickshell config
- `assets/cwc/` — quickshell cwc widget files
- `assets/toggle-launcher` — launcher toggle script

**Dependencies:** `compositor` (auto-started by hyprland/niri exec-once)