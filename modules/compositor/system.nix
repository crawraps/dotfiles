{ pkgs, preferences, lib, ... }:
let cfg = preferences.modules.compositor; in
lib.mkMerge [
  (lib.mkIf cfg.hyprland { programs.hyprland.enable = true; })
  (lib.mkIf cfg.niri { programs.niri.enable = true; programs.niri.package = pkgs.niri; })
]