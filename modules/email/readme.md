# email

thunderbird email client with protonmail-bridge.

**Preference key:** `preferences.modules.email`
**Default:** `true`

**Files:**
- `home.nix` — protonmail-bridge package, thunderbird with user chrome customization
- `assets/thunderbird-chrome/` — custom thunderbird css

**Dependencies:** `appearance` (wallust generates thunderbird color template), `compositor` (auto-starts protonmail-bridge at login)