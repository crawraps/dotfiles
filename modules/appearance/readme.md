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

## paper

Wallpaper setter wrapping `awww` and `wallust`, with manual palette overrides and a dark/light mode toggle.

### Manual palettes

One JSON file per wallpaper lives in `$CACHE/paper/palettes/<group>/<name>.json`, mirroring `$WALLPAPERS`. Each file holds the full wallust palette (`background`, `foreground`, `cursor`, `color0`..`color15`). When present, it is applied via `wallust cs` instead of generating from the image.

| command | action |
|---|---|
| `paper -e [wallpaper]` / `--edit-palette` | open the palette JSON in `$EDITOR`; seeds it from generated colors if missing (uses current wallpaper if none given) |
| `paper -c <wallpaper>` / `--clear-palette` | delete a manual override |
| `paper --list-palettes` | list all overrides |
| `paper --show-palette [wallpaper]` | print the manual palette, or generate+print it if none exists |

### Dark/light mode

Mode is stored in `$CACHE/paper/mode` (`dark` or `light`, default `dark`). It only affects auto-generated palettes (wallust `dark16`/`light16`); manual palettes always win.

| command | action |
|---|---|
| `paper -d` / `--dark` | use dark mode and set as default |
| `paper -L` / `--light` | use light mode and set as default |
| `paper --toggle-mode` | toggle default mode |
| `paper --mode dark\|light` | set default mode without changing wallpaper |

**Dependency:** `jq` (used to parse `awww query` for the current wallpaper).