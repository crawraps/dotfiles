# git

git configuration with optional lazygit TUI.

**Preference key:** `preferences.modules.git`
**Default:** `{ tui = true; }`

Accepts `true` or an attrs with `tui` sub-flag.

**Files:**
- `home.nix` — git config (user name/email from preferences), installs lazygit when `{ tui = true; }`

**Dependencies:** `user` (reads `preferences.user.name` and `preferences.user.email`)