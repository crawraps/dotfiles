declarative NixOS system configuration managed via flakes with a modular preferences API

## structure

```
.nix/
├── flake.nix              # entry point, preferences, module resolution
├── flake.lock
├── secrets/               # sensitive keys (tailscale, etc.) gitignored
└── modules/
    ├── configuration.nix  # system entry — imports hardware + bundle
    ├── bundle.nix          # imports all system-level modules
    ├── home-bundle.nix     # imports all home-manager modules
    ├── agents/            # AI agents (ollama, claude, opencode)
    ├── appearance/        # theming, wallpapers, wallust, fonts
    ├── auth/              # doas (replaces sudo)
    ├── bluetooth/         # bluetooth + optional bluetui
    ├── bootloader/        # systemd-boot + rEFInd
    ├── browser/           # browser modules
    │   ├── zen/           # zen browser (twilight)
    │   ├── firefox/       # firefox nightly
    │   └── chromium/      # chromium
    ├── compositor/        # wayland compositors
    │   ├── hyprland/      # hyprland config
    │   └── niri/          # niri config
    ├── desktop-entries/   # xdg mime + desktop file overrides
    ├── development/       # dev toolchain (node, cmake, etc.)
    ├── direnv/            # direnv + nix-direnv
    ├── docker/            # docker daemon
    ├── email/            # thunderbird + protonmail-bridge
    ├── environment/       # env vars + zsh
    │   └── zsh/           # zsh aliases + variables
    ├── git/              # git + optional lazygit
    ├── hardware/         # auto-generated hardware scan
    ├── kde-connect/      # kde connect + firewall
    ├── keyboard/         # keyd (caps→alt, vim nav layer)
    ├── ld/               # nix-ld (dynamic linker)
    ├── locale/           # timezone + locale
    ├── media/            # pipewire base
    │   ├── sound/        # wiremix, mpd (optional)
    │   └── video/        # mpv, imv, obs (optional)
    ├── mongodb/          # mongodb-ce service
    ├── neovim/           # neovim + neovide
    ├── network/          # networkmanager, dns-over-tls, tailscale
    ├── productivity/     # obsidian, workflow scripts
    ├── screenshots/      # grim, slurp, hyprquickshot
    ├── security/         # gpg + password-store
    ├── system-maintenance/ # fstrim, tlp, upower, nix gc
    ├── terminal/         # terminal modules
    │   ├── foot/         # foot + foot server
    │   └── kitty/        # kitty
    ├── user/             # user account + autologin
    ├── utilities/        # cli essentials (fd, rg, jq, etc.)
    ├── widgets/          # widget/panel modules
    │   ├── qs/           # quickshell (cwc)
    │   ├── ags/          # ags
    │   └── sherlock/     # sherlock launcher
    └── yazi/             # yazi file manager + plugins
```

## install / rebuild

```bash
# first install (from a live system)
sudo nixos-install --flake .#nixos

# rebuild after changes
sudo nixos-rebuild switch --flake .#nixos
```

## preferences API

all configuration is driven by the `preferences` attrset in `flake.nix`. the entire attrset is passed to every module via `specialArgs`, so any module can read any preference.

### module toggle logic

each module reads its flag from `preferences.modules.*` and self-guards with `lib.mkIf`:

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

the preference key maps directly: `preferences.modules.git` → the `git` module.

### module table

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
| yazi | `preferences.modules.yazi` | `bool` | `true` | yazi file manager with plugins and catppuccin theme |

## credits / license

personal configuration — no explicit license.