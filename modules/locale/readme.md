# locale

timezone and locale settings.

**Preference key:** `preferences.modules.locale`
**Default:** `true`

**Files:**
- `system.nix` — sets `time.timeZone` and `i18n.defaultLocale` from `preferences.system.timezone` and `preferences.system.locale`

**Dependencies:** reads `preferences.system.*`