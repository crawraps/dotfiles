# environment

system environment variables and zsh shell configuration.

**Preference key:** `preferences.modules.env`
**Default:** `{ zsh = true; }`

**Files:**
- `system.nix` — system env vars (EDITOR=nvim, xdg paths, QT_QPA_PLATFORMTHEME, etc.), NIXOS_OZONE_WL session var
- `home.nix` — full zsh config: oh-my-zsh, autosuggestions, syntax highlighting, nix-shell plugin, prompt, auto-start compositor on tty1 login
- `zsh/aliases.nix` — shell aliases (parameterized by terminal selection)
- `zsh/variables.nix` — session variables

**Dependencies:** `compositor` (reads `preferences.modules.compositor.hyprland/niri` for auto-start command), `terminal` (reads foot/kitty for aliases)