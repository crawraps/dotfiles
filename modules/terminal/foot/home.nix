{ preferences, lib, ... }:

let cfg = preferences.modules.terminal; in
lib.mkIf cfg.foot {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        font = "Kode Mono:size=11";
      };

      bell.system = "no";

      "colors-dark" = {
        alpha = "0.5";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  xdg.desktopEntries = {
    foot = {
      name = "Foot";
      exec = "footclient";
      terminal = false;
      icon = ./assets/pictures/terminal.svg;
      categories = [ "System" "TerminalEmulator" ];
      comment = "footclient";
      type = "Application";
    };
  };
}