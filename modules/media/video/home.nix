{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.media;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";
in
lib.mkIf (cfg != false) {
  home.packages = with pkgs; []
    ++ lib.optionals (builtins.isAttrs cfg && cfg.video.players or false) [ mpv imv ]
    ++ lib.optionals (builtins.isAttrs cfg && cfg.video.recording or false) [ obs-studio ];

  xdg.desktopEntries = {}
    // lib.optionalAttrs (builtins.isAttrs cfg && cfg.video.players or false) {
      mpv = {
        name = "mpv";
        exec = "mpv";
        terminal = false;
        icon = ./assets/pictures/mpv-player.svg;
        categories = [ "AudioVideo" "Video" ];
        comment = "Media player based on MPlayer and mplayer2";
        type = "Application";
      };
    }
    // lib.optionalAttrs (builtins.isAttrs cfg && cfg.video.recording or false) {
      obs-studio = {
        name = "OBS Studio";
        exec = "obs";
        terminal = false;
        icon = ./assets/pictures/obs.svg;
        categories = [ "AudioVideo" "Video" ];
        comment = "Open Broadcaster Software for video recording and live streaming";
        type = "Application";
      };
    };
}