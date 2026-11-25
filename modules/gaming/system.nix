{ lib, preferences, ... }:
{
  config = lib.mkIf preferences.modules.gaming.steam {
    hardware.graphics.enable32Bit = true;
    programs.gamemode.enable = true;
    programs.steam.enable = true;
  };
}
