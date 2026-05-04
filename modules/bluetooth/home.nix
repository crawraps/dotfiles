{ pkgs, preferences, lib, ... }:
let
  cfg = preferences.modules.bluetooth;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";
in
lib.mkIf (builtins.isAttrs cfg && cfg.tui or false) {
  home.packages = with pkgs; [ bluetui ];

  xdg.desktopEntries = {
    bluetooth-manager = {
      name = "Bluetooth Manager";
      exec = "${terminal-cmd} bluetui";
      terminal = false;
      icon = ./assets/pictures/bluetooth.svg;
      categories = [ "Network" "Utility" ];
      comment = "bluetui";
      type = "Application";
    };
  };
}