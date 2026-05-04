{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.widgets; in
lib.mkIf cfg.qs {
  home.packages = with pkgs; [ quickshell ];

  home.file = {
    toggle-launcher = { source = ./assets/toggle-launcher; target = ".local/bin/toggle-launcher"; executable = true; };
  };

  xdg.configFile = {
    "quickshell/cwc" = { source = ./assets/cwc; recursive = true; };
  };
}