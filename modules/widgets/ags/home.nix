{ preferences, lib, ... }:

let cfg = preferences.modules.widgets; in
lib.mkIf cfg.ags {
  xdg.configFile.ags = { source = ./assets/config; };
}