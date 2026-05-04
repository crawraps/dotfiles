# appearance

theming, fonts, wallpapers, and dynamic color generation.

**Preference key:** `preferences.modules.appearance`
**Default:** `true`

**Files:**
- `system.nix` — system fonts (roboto, kode-mono, comfortaa, nerd-fonts, material-symbols)
- `home.nix` — wallust (color generator), gtk theme, bibata cursor, icon theme, wallpaper script (`paper`), color apply script (`dye`)
- `assets/` — wallpaper, wallust templates
- `scripts/` — `paper` (wallpaper setter), `dye` (color applier)

**Dependencies:** reads `preferences.modules.browser` and `preferences.modules.terminal` to generate per-app color templates