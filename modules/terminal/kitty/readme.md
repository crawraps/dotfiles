# terminal / kitty

kitty terminal emulator.

**Preference key:** `preferences.modules.terminal.kitty`
**Default:** `false`

**Files:**
- `home.nix` — enables kitty with kode mono font, zsh integration, 50% background opacity, remote control via unix socket, includes `colors.conf` from appearance module

**Dependencies:** `appearance` (wallust generates kitty color template)