# user

user account creation and shell setup.

**Preference key:** `preferences.modules.user`
**Default:** `true`

**Files:**
- `system.nix` — creates user from `preferences.user.name`, adds to `preferences.user.extraGroups`, sets zsh as default shell, enables autologin, creates gnupg directory

**Dependencies:** `environment` (zsh must be enabled for `programs.zsh.enable`)