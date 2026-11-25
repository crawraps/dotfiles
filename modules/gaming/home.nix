{ lib, preferences, ... }:
lib.mkIf preferences.modules.gaming.steam {
  home.file.game-mode = {
    source = ./scripts/game-mode;
    target = ".local/bin/game-mode";
    executable = true;
  };
}
