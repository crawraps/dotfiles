{ pkgs, preferences, lib, config, ... }:
let
  cfg = preferences.modules.appearance;
  inherit (preferences.modules) terminal browser;
  inherit (preferences.user) name;

  firefox-enabled = browser.firefox || (builtins.typeOf browser != "bool" && browser.firefox or false);
  zen-browser-enabled = browser.zen || (builtins.typeOf browser != "bool" && browser.zen or false);

  kittyTemplates = lib.optionalAttrs (terminal.kitty or false) {
    kitty = { template = "kitty.conf"; target = "~/.config/dynamic-colors/kitty.conf"; };
  };

  firefoxTemplates = lib.optionalAttrs firefox-enabled {
    firefox = { template = "firefox.css"; target = "~/.config/dynamic-colors/firefox.css"; };
    firefoxUserContent = { template = "firefox-userContent.css"; target = "~/.config/dynamic-colors/firefox-userContent.css"; };
  };

  zenTemplates = lib.optionalAttrs zen-browser-enabled {
    zen = { template = "zen.css"; target = "~/.config/dynamic-colors/zen.css"; };
    zenUserContent = { template = "firefox-userContent.css"; target = "~/.config/dynamic-colors/zen-userContent.css"; };
  };
in
lib.mkIf cfg {
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 16;
    package = pkgs.bibata-cursors;
  };

  gtk = {
    enable = true;
    gtk4.theme = null;
    iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 12;
    };
  };

  home.file."images/wallpapers/common/default.png".source = ./assets/wallpaper.png;

  home.file = {
    paper = { source = ./scripts/paper; target = ".local/bin/paper"; executable = true; };
    dye = { source = ./scripts/dye; target = ".local/bin/dye"; executable = true; };
    broadcast-term-colors = { source = ./scripts/broadcast-term-colors; target = ".local/bin/broadcast-term-colors"; executable = true; };
  };

  home.packages = with pkgs; [
    awww
    dart-sass
  ];

  programs.wallust = {
    enable = true;
    settings = {
      backend = "thumb";
      color_space = "lab";
      threshold = 9;
      palette = "dark16";
      alpha = 50;
      templates = {
        ags = { template = "ags.scss"; target = "~/.config/dynamic-colors/ags.scss"; };
        thunderbird = { template = "thunderbird.css"; target = "~/.config/dynamic-colors/thunderbird.css"; };
        obsidian = { template = "obsidian.scss"; target = "~/.config/dynamic-colors/obsidian.scss"; };
        neovim = { template = "neovim.lua"; target = "~/.config/dynamic-colors/neovim.lua"; };
        hyprland = { template = "hyprland.conf"; target = "~/.config/dynamic-colors/hyprland.conf"; };
        cwc = { template = "cwc.json"; target = "~/.config/dynamic-colors/cwc.json"; };
        terminal = { template = "terminal"; target = "~/.config/dynamic-colors/terminal"; };
      } // kittyTemplates // firefoxTemplates // zenTemplates;
    };
  };

  xdg.configFile."wallust/templates" = {
    source = ./assets/templates;
    recursive = true;
  };
}
