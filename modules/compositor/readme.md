# compositor

wayland compositor selection — imports hyprland and/or niri based on preference flags.

**Preference key:** `preferences.modules.compositor`
**Default:** `{ hyprland = true; niri = false; }`

**Files:**
- `system.nix` — enables `programs.hyprland` and/or `programs.niri` based on sub-flags
- `home.nix` — imports sub-module home configs conditionally

**Sub-modules:**

| sub-module | preference key | description |
|------------|---------------|-------------|
| `hyprland/` | `compositor.hyprland` | hyprland wayland compositor |
| `niri/` | `compositor.niri` | niri scroll-tiling wayland compositor |

**Dependencies:** `terminal` (reads `preferences.modules.terminal.foot/kitty` for terminal command), `widgets` (auto-starts quickshell), `email` (auto-starts protonmail-bridge)