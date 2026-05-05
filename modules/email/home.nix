{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.email;
  inherit (preferences.user) name;
in
lib.mkIf cfg {
  home.packages = with pkgs; [
    protonmail-bridge
  ];

  programs.thunderbird = {
    enable = true;

    profiles.${name} = {
      isDefault = true;

      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("svg.context-properties.content.enabled", true);
        user_pref("layout.css.has-selector.enabled", true);
        user_pref("widget.gtk.rounded-bottom-corners.enabled", true);
      '';
    };
  };

  home.file.thunderbirdChrome = {
    source = ./assets/thunderbird-chrome;
    target = ".thunderbird/${name}/chrome";
    recursive = true;
  };

  xdg.desktopEntries = {
    thunderbird = {
      name = "Thunderbird";
      exec = "thunderbird";
      terminal = false;
      icon = ./assets/pictures/thunderbird.svg;
      categories = [ "Network" "Email" ];
      comment = "Email client from Mozilla";
      type = "Application";
    };
  };

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    windowrule = [
      "opaque on, match:class thunderbird"
      "float on, match:class thunderbird, match:title ^(Write:)$"
    ];
  };
}