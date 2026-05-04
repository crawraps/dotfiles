# media / video

video and image viewers with optional recording.

**Preference key:** `preferences.modules.media.video`
**Default:** `{ players = true; recording = true; }`

**Files:**
- `home.nix` — installs mpv + imv when `{ players = true; }`, obs-studio when `{ recording = true; }`
- `assets/` — video-related assets

**Dependencies:** `media` (parent module, pipewire must be enabled at system level)