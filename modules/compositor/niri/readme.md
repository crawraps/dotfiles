# compositor / niri

niri scroll-tiling wayland compositor configuration.

**Preference key:** `preferences.modules.compositor.niri`
**Default:** `false`

**Files:**
- `system.nix` — enables `programs.niri`
- `home.nix` — niri settings, spawn-at-startup (foot server, paper, quickshell, protonmail-bridge)
- `io.nix` — input devices, touchpad
- `keymaps.nix` — keybindings
- `layout.nix` — layout rules, window placement

**Dependencies:** `terminal` (foot/kitty selection), `widgets` (qs auto-start), `email` (protonmail-bridge auto-start)