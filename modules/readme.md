# modules

all configuration lives under `modules/` in a flat structure. each module directory contains one or both of:

| file | scope | loaded by |
|------|-------|-----------|
| `system.nix` | NixOS system-level (services, hardware, networking) | `bundle.nix` |
| `home.nix` | home-manager user-level (packages, programs, dotfiles) | `home-bundle.nix` |

every module self-guards with `lib.mkIf` based on its preference flag from `preferences.modules.*`:

```nix
# modules/git/home.nix
{ preferences, lib, ... }:
lib.mkIf preferences.modules.git {
  programs.git.enable = true;
}
```

some modules contain sub-modules (e.g. `compositor/hyprland/`, `browser/zen/`) that are imported conditionally by the parent module based on sub-preference flags.

modules with `assets/` ship static files (configs, templates, icons). modules with `scripts/` ship executable scripts installed to `~/.local/bin/`.