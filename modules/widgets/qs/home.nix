{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.widgets; in
lib.mkIf cfg.qs {
  home.packages = with pkgs; [ quickshell ];

  home.file = {
    toggle-launcher = { source = ./assets/toggle-launcher; target = ".local/bin/toggle-launcher"; executable = true; };
  };

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    window_rule = [
      { match = { title = "CWC-Launcher-Terminal.*"; }; float = true; persistent_size = true; }
    ];
    layer_rule = [
      { match = { namespace = "^(cwc_).*"; }; blur         = true; }
      { match = { namespace = "^(cwc_).*"; }; ignore_alpha = 0.2; }
      { match = { namespace = "^(cwc_).*"; }; no_anim      = true; }
    ];
  };

# Disabled while in development
#  xdg.configFile = {
#    "quickshell/cwc" = { source = ./assets/cwc; recursive = true; };
#  };
}
