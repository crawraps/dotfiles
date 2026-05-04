{ pkgs, inputs, system, preferences, lib, ... }:

let
  cfg = preferences.modules.browser;
  inherit (preferences.user) name;
in
lib.mkIf cfg.zen {
  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };

    profiles.${name} = {
      id = 0;
      name = name;
      isDefault = true;

      extraConfig = ''
        user_pref("browser.tabs.allow_transparent_browser", true);
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("svg.context-properties.content.enabled", true);
      '';
    };
  };

  home.file.zenChrome = {
    source = ./assets/zen-chrome;
    target = ".zen/${name}/chrome";
    recursive = true;
  };

  xdg.desktopEntries = {
    youtube-music = {
      name = "YouTube Music";
      exec = "zen-twilight --new-window https://music.youtube.com";
      terminal = false;
      icon = ./assets/pictures/youtube-music.svg;
      categories = [ "AudioVideo" "Audio" ];
      comment = "zen music.youtube.com";
      type = "Application";
    };
    zen = {
      name = "Zen twilight";
      exec = "zen-twilight";
      terminal = false;
      icon = ./assets/pictures/zen.svg;
      comment = "A minimal web browser";
      type = "Application";
      actions = {
        new-window = {
          name = "New Window";
          exec = "zen-twilight --new-window";
        };
        new-private-window = {
          name = "New Private Window";
          exec = "zen-twilight --private-window";
        };
        profile-manager-window = {
          name = "Profile Manager";
          exec = "zen-twilight --ProfileManager";
        };
      };
    };
    youtube = {
      name = "YouTube";
      exec = "zen-twilight --new-window https://www.youtube.com";
      terminal = false;
      icon = ./assets/pictures/youtube.svg;
      categories = [ "AudioVideo" "Audio" ];
      comment = "zen youtube.com";
      type = "Application";
    };
    telegram = {
      name = "Telegram";
      exec = "zen-twilight --new-window https://web.telegram.org";
      terminal = false;
      icon = ./assets/pictures/telegram.svg;
      categories = [ "Network" "InstantMessaging" ];
      comment = "zen web.telegram.org";
      type = "Application";
    };
    tasks = {
      name = "Tasks";
      exec = "zen-twilight --new-window https://tasks.google.com";
      terminal = false;
      icon = ./assets/pictures/google-tasks.svg;
      comment = "zen tasks.google.com";
      type = "Application";
    };
  };
}