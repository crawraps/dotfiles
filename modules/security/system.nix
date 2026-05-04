{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.security;
  inherit (preferences.user) name;
in
lib.mkIf cfg {
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}