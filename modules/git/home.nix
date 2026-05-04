{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.git;
  inherit (preferences.user) name email;
in
lib.mkIf (cfg != false) {
  programs.git = {
    enable = true;
    settings.user = {
      name = name;
      email = email;
    };
    signing.format = null;
  };

  home.packages = lib.optionals (builtins.isAttrs cfg && cfg.tui or false) [
    pkgs.lazygit
  ];
}