# compositor / hyprland

hyprland wayland compositor configuration.

**Preference key:** `preferences.modules.compositor.hyprland`
**Default:** `true`

**Files:**
- `system.nix` — enables `programs.hyprland`
- `home.nix` — hyprland window manager config, exec-once (foot server, paper, quickshell, protonmail-bridge), sources `colors.conf`
- `appearance.nix` — window rules, animations, decoration
- `io.nix` — input devices, gestures
- `keymaps.nix` — keybindings
- `layout.nix` — workspace layout, window placement rules
- `variables.nix` — environment variables, monitor config

**Dependencies:** `terminal` (foot/kitty selection), `widgets` (qs auto-start), `email` (protonmail-bridge auto-start), `appearance` (sources colors.conf)