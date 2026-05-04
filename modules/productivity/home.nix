{ pkgs, pkgs-stable, preferences, lib, ... }:

let cfg = preferences.modules.productivity; in
lib.mkIf cfg {
  home.file = {
    workflow = { source = ./scripts/workflow; target = ".local/bin/workflow"; executable = true; };
    work-timer = { source = ./scripts/work-timer; target = ".local/bin/work-timer"; executable = true; };
  };

  home.packages = [
    pkgs-stable.obsidian
    pkgs-stable.mongodb-compass
  ];

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "obsidian";
      terminal = false;
      icon = ./assets/pictures/obsidian.svg;
      categories = [ "Utility" "TextEditor" ];
      comment = "A powerful knowledge base on local Markdown files";
      type = "Application";
    };
  };
}