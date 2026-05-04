{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.text-editor.neovim;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";
in
lib.mkIf cfg {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
  };

  home.packages = with pkgs; [
    neovide
  ];

  xdg.configFile.nvim = {
    source = ./assets/nvim;
    recursive = true;
  };

  xdg.configFile.neovide = {
    source = ./assets/neovide;
    recursive = true;
  };

  xdg.desktopEntries = {
    neovide = {
      name = "Vide";
      exec = "neovide %F";
      terminal = false;
      icon = ./assets/pictures/neovide.svg;
      categories = [ "Utility" "TextEditor" ];
      comment = "neovide";
      mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c+" ];
    };
    nvim = {
      name = "Neovim";
      exec = "${terminal-cmd} nvim";
      icon = ./assets/pictures/neovide.svg;
      categories = [ "Utility" "TextEditor" ];
      comment = "nvim";
      mimeType = [ "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c+" ];
    };
  };
}