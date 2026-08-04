{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.voxtype;
  voxtype = pkgs.voxtype.override { onnxSupport = true; };
in
lib.mkIf cfg {
  home.file = {
    voxtype-config = { source = ./assets/config.toml; target = ".config/voxtype/config.toml"; };
    voxtype-toggle = { source = ./scripts/voxtype-toggle; target = ".local/bin/voxtype-toggle"; executable = true; };
  };

  systemd.user.services.voxtype = {
    Unit = {
      Description = "Voxtype push-to-talk dictation daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${voxtype}/bin/voxtype daemon";
      Restart = "on-failure";
      RestartSec = 2;
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "DISPLAY=:0"
        "QT_QPA_PLATFORM=wayland"
      ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}