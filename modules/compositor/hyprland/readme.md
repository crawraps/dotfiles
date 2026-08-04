# compositor / hyprland

hyprland wayland compositor configuration, written in **Lua** (hyprlang is deprecated since Hyprland 0.55).

**Preference key:** `preferences.modules.compositor.hyprland`
**Default:** `true`

**Files:**
- `system.nix` — enables `programs.hyprland`
- `home.nix` — sets `configType = "lua"`, declares `extraLuaFiles` (loads every `lua/*.lua` module), generates `variables.lua` from Nix (interpolates `foot` vs `kitty`), and appends the autostart hook + block submap via `extraConfig`
- `lua/variables.lua` — generated from Nix; exposes `mod`, `term`, `launcher` to other modules via `require("variables")`
- `lua/io.lua` — monitors, input, gestures
- `lua/keymaps.lua` — keybindings, mouse binds, media keys
- `lua/layout.lua` — dwindle/master, workspace rules, window rules, misc, xwayland
- `lua/appearance.lua` — general, decoration, animations, curves
- `lua/env.lua` — env vars, debug flags

**Dependencies:** `terminal` (foot/kitty selection drives `variables.lua`), `widgets` (qs auto-start), `email` (protonmail-bridge auto-start)

**Note:** the old hyprlang `source = colors.conf` directive has no Lua equivalent; color variables previously sourced from `~/.config/hypr/colors.conf` are no longer referenced by this config.