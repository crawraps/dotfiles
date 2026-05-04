{ lib, pkgs, pkgs-stable, preferences, ... }:

let
  cfg = preferences.modules.compositor;
  inherit (preferences.modules.terminal) foot kitty;
  term = if foot then "footclient" else "kitty -1";
  inherit (preferences.user) name;
in
lib.mkIf cfg.hyprland {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    sourceFirst = true;

    settings = lib.mkMerge [
      (import ./variables.nix { inherit preferences; })
      (import ./io.nix)
      (import ./layout.nix)
      (import ./appearance.nix)
      (import ./keymaps.nix { inherit name; })
      {
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland"
        ];

        exec-once = []
          ++ lib.optionals foot [ "foot --server" ]
          ++ [ "bash -c '~/.local/bin/paper -g common'" ]
          ++ lib.optionals preferences.modules.widgets.qs [ "quickshell -dn -c cwc" ]
          ++ lib.optionals preferences.modules.email [ "protonmail-bridge --noninteractive" ];

        source = [
          "colors.conf"
        ];

        debug = {
          disable_logs = false;
          disable_time = false;
        };
      }
    ];

    extraConfig = ''
      submap = block
      bind = , catchall, exec,
      submap = reset
    '';
  };
}