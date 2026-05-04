{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.browser; in
lib.mkIf cfg.chromium {
  home.packages = with pkgs; [ chromium ];

  xdg.desktopEntries = {
    chromium = {
      name = "Chromium";
      exec = "chromium";
      terminal = false;
      icon = ./assets/pictures/chromium.svg;
      categories = [ "Network" "WebBrowser" ];
      comment = "Web browser from the Chromium project";
      type = "Application";
      actions = {
        new-window = {
          name = "New Window";
          exec = "chromium --new-window";
        };
        new-private-window = {
          name = "New Private Window";
          exec = "chromium --incognito";
        };
      };
    };
  };
}