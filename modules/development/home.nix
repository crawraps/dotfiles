{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.development; in
lib.mkIf cfg {
  home.packages = with pkgs; [ nodejs_22 cmake meson tree-sitter ];
}