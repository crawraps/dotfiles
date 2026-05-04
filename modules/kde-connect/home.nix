{ preferences, lib, ... }:

lib.mkIf preferences.modules.kdeConnect {
  services.kdeconnect.enable = true;

  xdg.desktopEntries = {
    kde-connect = {
      name = "KDE Connect";
      exec = "kdeconnect-app";
      terminal = false;
      icon = ./assets/pictures/kde-connect.svg;
      categories = [ "Network" "Utility" ];
      comment = "Connect your phone to your computer";
      type = "Application";
    };
  };
}