{ lib, config, pkgs, inputs, username, ... }:
let
  plugins-dir = "/home/careem/.local/share/hypr/plugins";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = lib.mkMerge [
      (import ./variables.nix)
      (import ./theme.nix)
      (import ./io.nix)
      (import ./layout.nix)
      (import ./appearance.nix)
      (import ./keymaps.nix)
      {
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_PICTURES_DIR,$HOME/images"
          "GRIM_DEFAULT_DIR,$HOME/images/screenshots"
          "QT_QPA_PLATFORM,wayland"
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];

        exec-once = [
          "hyprctl plugin load ${plugins-dir}/workspace-layouts.so"
          "bash -c '~/.local/bin/paper'"
        ];

        debug = {
          disable_logs = false;
          disable_time = false;
        };

        plugin = {
          wslayout = {
            default_layout = "dwindle";
          };
        };
      }
    ];
  };
}
