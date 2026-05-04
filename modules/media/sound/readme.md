# media / sound

audio controls and optional music player daemon.

**Preference key:** `preferences.modules.media.sound`
**Default:** `{ players = false; }`

**Files:**
- `home.nix` — wiremix, pulseaudio cli, wireplumber config; installs mpd when `{ players = true; }`
- `assets/wireplumber/` — wireplumber config files

**Dependencies:** `media` (parent module, pipewire must be enabled at system level)