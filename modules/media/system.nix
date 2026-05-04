{ lib, preferences, ... }:

let cfg = preferences.modules.media; in
lib.mkIf (cfg == true || builtins.isAttrs cfg) {
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}