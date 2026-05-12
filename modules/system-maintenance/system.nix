{ lib, pkgs, preferences, ... }:

let
  cfg = preferences.modules.system-maintenance;
  inherit (preferences.user) name;
in
lib.mkIf (cfg == true || builtins.isAttrs cfg) {
  services.fstrim.enable = true;

  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 10;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      PLATFORM_PROFILE_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "power";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  system.autoUpgrade = lib.mkIf (builtins.isAttrs cfg && cfg.auto-update or false) {
    enable = true;
    flake = "/home/${name}/.nix";
    flags = [
      "--print-build-logs"
      "--commit-lock-file"
    ];
    dates = "Thu *-*-* 04:00:00";
    randomizedDelaySec = "45min";
  };

  systemd.services.nixos-upgrade = lib.mkIf (builtins.isAttrs cfg && cfg.auto-update or false) {
    path = [ pkgs.git pkgs.nix ];
    preStart = ''
      cd /home/${name}/.nix
      ${pkgs.nix}/bin/nix flake update --commit-lock-file
    '';
  };

  nix.gc = lib.mkIf (builtins.isAttrs cfg && cfg.collect-garbage or false) {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
