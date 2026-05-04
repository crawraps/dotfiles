Declarative NixOS system configuration managed via flakes with a modular preferences API

## Structure

```
.nix/
├── flake.nix              # entry point, preferences, module resolution
├── flake.lock
├── secrets/               # sensitive keys (tailscale, etc.) gitignored
└── modules/
    ├── configuration.nix  # system entry — imports hardware + bundle
    ├── bundle.nix         # imports all system-level modules
    ├── home-bundle.nix    # imports all home-manager modules
    └── ...modules
```

## Install / Rebuild

```bash
# first install (from a live system)
sudo nixos-install --flake .#nixos

# rebuild after changes
sudo nixos-rebuild switch --flake .#nixos
```

## Preferences API

All configuration is driven by the `preferences` attrset in `flake.nix`. the entire attrset is passed to every module via `specialArgs`, so any module can read any preference.

### Module toggle logic

Each module reads its flag from `preferences.modules.*` and self-guards with `lib.mkIf`:

```nix
# example: modules/git/home.nix
{ preferences, lib, ... }:
lib.mkIf preferences.modules.git {
  programs.git.enable = true;
}
```

- `true` — module is enabled
- `false` — module is disabled
- attrs (e.g. `{ tui = true; }`) — module is enabled with sub-options

The preference key maps directly: `preferences.modules.git` → the `git` module.

### Module table

| module | preference key | type | default | description |
|--------|---------------|------|---------|-------------|
| agents | `preferences.modules.agents` | `{ claude = bool; gemini = bool; opencode = bool; ollama = bool; }` | `{ claude = false; gemini = false; opencode = true; ollama = true; }` | AI agents — ollama runs as system service, others are home packages |
| appearance | `preferences.modules.appearance` | `bool` | `true` | theming: wallust, gtk, icons, cursors, fonts, wallpaper scripts |
| auth | `preferences.modules.auth` | `bool` | `true` | replaces sudo with doas |
| bluetooth | `preferences.modules.bluetooth` | `bool \| { tui = bool; }` | `{ tui = true; }` | bluetooth hardware + optional bluetui |
| bootloader | `preferences.modules.bootloader` | `bool` | `true` | systemd-boot with rEFInd |
| browser | `preferences.modules.browser` | `{ zen = bool; firefox = bool; chromium = bool; }` | `{ zen = true; firefox = false; chromium = true; }` | browser selection, only one needed — sub-modules toggle individually |
| compositor | `preferences.modules.compositor` | `{ hyprland = bool; niri = bool; }` | `{ hyprland = true; niri = false; }` | wayland compositor — imports sub-modules based on flags |
| desktop-entries | `preferences.modules` (reads multiple) | — | — | xdg mime defaults + custom .desktop files (reads browser, terminal, other module flags) |
| development | `preferences.modules.development` | `bool` | `true` | dev toolchain: nodejs, cmake, meson, tree-sitter |
| direnv | `preferences.modules.direnv` | `bool` | `true` | direnv + nix-direnv with zsh integration |
| docker | `preferences.modules.docker` | `bool` | `false` | docker daemon with ipv6 support |
| email | `preferences.modules.email` | `bool` | `true` | thunderbird + protonmail-bridge |
| environment | `preferences.modules.env` | `{ zsh = bool; }` | `{ zsh = true; }` | system env vars + zsh (aliases, variables, oh-my-zsh, auto-start compositor) |
| git | `preferences.modules.git` | `bool \| { tui = bool; }` | `{ tui = true; }` | git config + optional lazygit |
| hardware | — (always imported) | — | — | auto-generated hardware scan from nixos-generate-config |
| kde-connect | `preferences.modules.kdeConnect` | `bool` | `true` | kde connect + firewall ports |
| keyboard | `preferences.modules.keyboard` | `bool` | `true` | keyd: caps→alt, vim-style nav layer |
| ld | `preferences.modules.ld` | `bool` | `true` | nix-ld for dynamic linker compat |
| locale | `preferences.modules.locale` | `bool` | `true` | timezone + locale from `preferences.system.*` |
| media | `preferences.modules.media` | `{ sound = { players = bool; }; video = { players = bool; recording = bool; }; }` | `{ sound = { players = false; }; video = { players = true; recording = true; }; }` | pipewire base, imports sound/video sub-modules |
| mongodb | `preferences.modules.mongodb` | `bool` | `false` | mongodb-ce service |
| neovim | `preferences.modules.neovim` | `bool` | `true` | neovim + neovide, config via assets |
| network | `preferences.modules.network` | `bool` | `true` | networkmanager, dns-over-tls (1.1.1.1), tailscale, nftables firewall |
| productivity | `preferences.modules.productivity` | `bool` | `true` | obsidian + workflow/timer scripts |
| screenshots | `preferences.modules.screenshots` | `bool` | `true` | grim, slurp, hyprpicker, hyprquickshot |
| security | `preferences.modules.security` | `bool` | `true` | gpg agent + pass (password-store) with otp |
| system-maintenance | `preferences.modules.system-maintenance` | `bool \| { tui = bool; }` | `{ tui = true; }` | fstrim, tlp, upower, nix gc + optional btop |
| terminal | `preferences.modules.terminal` | `{ foot = bool; kitty = bool; }` | `{ foot = true; kitty = false; }` | terminal selector — imports foot/kitty sub-modules |
| user | `preferences.modules.user` | `bool` | `true` | user account, groups, autologin |
| utilities | `preferences.modules.utilities` | `bool` | `true` | cli essentials: fd, rg, jq, ripgrep, wl-clipboard, etc. |
| widgets | `preferences.modules.widgets` | `{ qs = bool; ags = bool; sherlock = bool; }` | `{ qs = true; ags = false; sherlock = false; }` | widget/panel selector — imports qs/ags/sherlock sub-modules |
| file-manager | `preferences.modules.file-manager` | `bool` | `true` | file manager, disk analyzer, trash manager, etc... |

## Secrets

The `secrets/` directory is **gitignored** and never committed, but some modules depend on files inside it to function correctly. You must create this directory and populate the required files manually:

| file | required by | description |
|------|-------------|-------------|
| `secrets/tailscale.key` | `network` | Tailscale auth key, referenced via `self + "/secrets/tailscale.key"` in `modules/network/system.nix` |

If a module's secret file is missing, the NixOS build will fail with a path error. Create the directory and add the needed files before rebuilding:

```bash
mkdir -p secrets
echo "tskey-auth-xxxxx" > secrets/tailscale.key
```

> **Note:** The `secrets/` directory and all `*.key` / `*.pem` / `*.env` files are excluded via `.gitignore`. Never commit credentials to this repository.

## Credits / License

personal configuration — no explicit license.
