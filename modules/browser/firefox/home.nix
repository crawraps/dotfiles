{ pkgs, inputs, system, preferences, lib, ... }:

let
  cfg = preferences.modules.browser;
  inherit (preferences.user) name;
in
lib.mkIf cfg.firefox {
  programs.firefox = {
    enable = true;

    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

    profiles.${name} = {
      id = 0;
      name = name;
      isDefault = true;

      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("svg.context-properties.content.enabled", true);
        user_pref("layout.css.has-selector.enabled", true);
        user_pref("browser.urlbar.suggest.calculator", true);
        user_pref("browser.urlbar.unitConversion.enabled", true);
        user_pref("browser.urlbar.trimHttps", true);
        user_pref("browser.urlbar.trimURLs", true);
        user_pref("widget.gtk.rounded-bottom-corners.enabled", true);
        user_pref("browser.tabs.allow_transparent_browser", true);
      '';
    };
  };

  home.file.firefoxChrome = {
    source = ./assets/firefox-chrome;
    target = ".mozilla/firefox/${name}/chrome";
    recursive = true;
  };

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    windowrule = [
      "idle_inhibit fullscreen, match:class firefox"
      "opaque on, match:class firefox-nightly"
      "no_shadow 0, match:class firefox-nightly"
    ];
  };
}