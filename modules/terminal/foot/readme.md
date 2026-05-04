# terminal / foot

foot terminal emulator with server mode.

**Preference key:** `preferences.modules.terminal.foot`
**Default:** `true`

**Files:**
- `home.nix` — enables foot in server mode (`foot --server`), kode mono font, 50% alpha, bell disabled, mouse hide on type

**Dependencies:** `compositor` (foot server auto-started by hyprland/niri exec-once)