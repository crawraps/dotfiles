# browser

browser selection — imports zen, firefox, or chromium based on preference flags.

**Preference key:** `preferences.modules.browser`
**Default:** `{ zen = true; firefox = false; chromium = true; }`

**Files:**
- `home.nix` — imports sub-module home configs conditionally

**Sub-modules:**

| sub-module | preference key | description |
|------------|---------------|-------------|
| `zen/` | `browser.zen` | zen browser (twilight) |
| `firefox/` | `browser.firefox` | firefox nightly |
| `chromium/` | `browser.chromium` | chromium |

**Dependencies:** `appearance` (wallust generates browser color templates), `desktop-entries` (reads browser flags for mime defaults and .desktop entries)