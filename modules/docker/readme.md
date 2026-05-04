# docker

docker daemon with ipv6 support.

**Preference key:** `preferences.modules.docker`
**Default:** `false`

**Files:**
- `system.nix` — enables docker with ipv6 (fixed cidr-v6 `fd00::/80`)

**Dependencies:** `user` (user must be in `docker` group via `preferences.user.extraGroups`)