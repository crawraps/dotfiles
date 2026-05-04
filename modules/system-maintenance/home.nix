{ lib, preferences, ... }:

let
  cfg = preferences.modules.system-maintenance;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";
in
lib.mkIf (builtins.isAttrs cfg && cfg.tui or false) {
  programs.btop.enable = true;

  xdg.desktopEntries = {
    btop = {
      name = "btop";
      exec = "${terminal-cmd} btop";
      terminal = false;
      icon = ./assets/pictures/processor.svg;
      categories = [ "System" ];
      comment = "Interactive process viewer for Unix systems";
      type = "Application";
    };
  };
}