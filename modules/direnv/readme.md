# direnv

direnv with nix-direnv integration.

**Preference key:** `preferences.modules.direnv`
**Default:** `true`

**Files:**
- `home.nix` — enables direnv with zsh integration, nix-direnv, and `use_nix_auto` stdlib (auto-detects flake.nix / shell.nix / default.nix)

**Dependencies:** `environment` (zsh integration requires zsh to be enabled)