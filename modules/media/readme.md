# media

pipewire audio base with conditionally imported sound and video sub-modules.

**Preference key:** `preferences.modules.media`
**Default:** `{ sound = { players = false; }; video = { players = true; recording = true; }; }`

**Files:**
- `system.nix` — disables pulseaudio, enables pipewire (alsa, pulse, 32-bit), enables rtkit
- `home.nix` — imports sound and/or video sub-modules based on preference flags

**Sub-modules:**

| sub-module | preference key | description |
|------------|---------------|-------------|
| `sound/` | `media.sound` | audio controls + optional music player daemon |
| `video/` | `media.video` | video/image players + optional obs studio |

**Dependencies:** none