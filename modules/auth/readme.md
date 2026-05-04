# auth

replaces sudo with doas for privilege escalation.

**Preference key:** `preferences.modules.auth`
**Default:** `true`

**Files:**
- `system.nix` — disables sudo, enables doas with persistent rules for the user
- `home.nix` — placeholder (future use)

**Dependencies:** `user` module (reads `preferences.user.name` for doas rules)