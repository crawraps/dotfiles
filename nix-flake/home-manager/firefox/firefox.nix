{ config, pkgs, inputs, ... }:
let
  profile = "careem";
in {
  programs.firefox = {
    enable = true;

    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

    profiles = {
      ${profile} = {
        id = 0;
        name = "${profile}";
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
          user_scheme("browser.tabs.allow_transparent_browser", true);
        '';
      };
    };
  };

  home.file.firefoxChrome = {
    source = ./chrome;
    target = ".mozilla/firefox/${profile}/chrome";
    recursive = true;
  };
}
