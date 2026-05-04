# browser / firefox

firefox nightly with custom chrome.

**Preference key:** `preferences.modules.browser.firefox`
**Default:** `false`

**Files:**
- `home.nix` — firefox nightly (from flake input), custom user prefs (transparent browser, stylesheets), custom chrome
- `assets/icons/` — custom svg icons
- `assets/firefox-chrome/` — custom browser chrome

**Dependencies:** `firefox` flake input