{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.media;
  inherit (preferences.user) name;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";
in
lib.mkIf (cfg != false) {
  home.packages = with pkgs; [
    wiremix
    pulseaudio
  ];

  xdg.configFile.wireplumber = {
    source = ./assets/wireplumber;
    recursive = true;
  };

  services.mpd = lib.mkIf (builtins.isAttrs cfg && cfg.sound.players or false) {
    enable = true;
    musicDirectory = "/home/${name}/music";
  };

  xdg.desktopEntries = {
    audio-mixer = {
      name = "Audio Mixer";
      exec = "${terminal-cmd} --title wiremix wiremix --tab output";
      terminal = false;
      icon = ./assets/pictures/mixer.svg;
      categories = [ "AudioVideo" "Audio" ];
      comment = "Wiremix audio mixer";
      type = "Application";
    };
  };
}