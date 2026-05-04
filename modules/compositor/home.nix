{ pkgs, pkgs-stable, inputs, system, preferences, lib, config, ... }:
let
  cfg = preferences.modules.compositor;
  logout-cmd = if cfg.hyprland then "hyprctl dispatch exit" else "";
in
{
  imports = []
    ++ lib.optionals cfg.hyprland [ ./hyprland/home.nix ]
    ++ lib.optionals cfg.niri [ ./niri/home.nix ];

  home.packages = with pkgs; [
    brightnessctl
    pamixer
  ];

  xdg.desktopEntries = {
    power-off = {
      name = "power-off";
      exec = "poweroff";
      terminal = false;
      icon = ./assets/pictures/power.svg;
    };
    sleep = {
      name = "sleep";
      exec = "systemctl suspend";
      terminal = false;
      icon = ./assets/pictures/sleep.svg;
    };
    logout = {
      name = "logout";
      exec = logout-cmd;
      terminal = false;
      icon = ./assets/pictures/logout.svg;
    };
  };
}
