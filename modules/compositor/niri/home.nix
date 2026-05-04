{ config, lib, pkgs, pkgs-stable, preferences, ... }:

let
  cfg = preferences.modules.compositor;
  inherit (preferences.modules.terminal) foot kitty;
  term = if foot then [ "footclient" ] else [ "kitty" "-1" ];
  actions = config.lib.niri.actions;
in
lib.mkIf cfg.niri {
  programs.niri.settings = lib.mkMerge [
    (import ./io.nix)
    (import ./layout.nix)
    {
      binds = import ./keymaps.nix { inherit actions term; };
    }
    {
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "~/images/screenshots/%Y-%m-%d_%H-%M-%S.png";

      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = null;
      };

      spawn-at-startup = []
        ++ lib.optionals foot [{ argv = [ "foot" "--server" ]; }]
        ++ [{ argv = [ "bash" "-c" "~/.local/bin/paper -g common" ]; }]
        ++ lib.optionals preferences.modules.widgets.qs [{ argv = [ "quickshell" "-dn" "-c" "cwc" ]; }]
        ++ lib.optionals preferences.modules.email [{ argv = [ "protonmail-bridge" "--noninteractive" ]; }];
    }
  ];
}