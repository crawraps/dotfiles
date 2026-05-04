{ pkgs, lib, preferences, ... }:

let cfg = preferences.modules.mongodb; in
lib.mkIf cfg {
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };
}