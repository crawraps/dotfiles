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

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    windowrule = [
      "float on, match:class pavucontrol"
      "float on, match:title wiremix"
      "float on, match:title ^(Volume Control)$"
      "size 800 600, match:title ^(Volume Control)$"
      "move 75 44%, match:title ^(Volume Control)$"
    ];
  };
}