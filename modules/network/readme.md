# network

networking, dns-over-tls, firewall, and tailscale VPN.

**Preference key:** `preferences.modules.network`
**Default:** `true`

**Files:**
- `system.nix` — networkmanager (wifi powersave off), nftables firewall, resolved with dns-over-tls (1.1.1.1), tailscale (auth key from secrets/), hostName from preferences

**Dependencies:** reads `preferences.system.hostname`, requires `secrets/tailscale.key`