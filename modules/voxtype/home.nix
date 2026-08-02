{ inputs, system, preferences, lib, ... }:

let cfg = preferences.modules.voxtype; in
lib.mkIf cfg {
  home.file = {
    voxtype-config = { source = ./assets/config.toml; target = ".config/voxtype/config.toml"; };
    voxtype-switch-whisper = { source = ./scripts/voxtype-switch-whisper; target = ".local/bin/voxtype-switch-whisper"; executable = true; };
    voxtype-switch-parakeet = { source = ./scripts/voxtype-switch-parakeet; target = ".local/bin/voxtype-switch-parakeet"; executable = true; };
    voxtype-toggle = { source = ./scripts/voxtype-toggle; target = ".local/bin/voxtype-toggle"; executable = true; };
  };

  systemd.user.services.voxtype = {
    Unit = { Description = "Voxtype push-to-talk dictation daemon"; };
    Service = { ExecStart = "${inputs.voxtype.packages.${system}.vulkan}/bin/voxtype daemon"; Restart = "on-failure"; };
    Install = { WantedBy = [ "default.target" ]; };
  };
}