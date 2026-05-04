{ lib, preferences, ... }:
let cfg = preferences.modules.bluetooth; in
lib.mkIf (cfg == true || builtins.isAttrs cfg) {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
}