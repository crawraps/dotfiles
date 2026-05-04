{ pkgs, lib, preferences, ... }:
let cfg = preferences.modules.appearance; in
lib.mkIf cfg {
  fonts.packages = with pkgs; [
    roboto
    kode-mono
    comfortaa
    nerd-fonts.symbols-only
    material-symbols
  ];
}