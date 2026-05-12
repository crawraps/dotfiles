{ lib, pkgs, preferences, ... }:

let cfg = preferences.modules.system-maintenance; in
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

  system.autoUpgrade = {
    enable = true;
    flake = "/home/careem/.nix";
    flags = [
      "--print-build-logs"
      "--commit-lock-file"
    ];
    dates = "Thu *-*-* 04:00:00";
    randomizedDelaySec = "45min";
  };

  systemd.services.nixos-upgrade = {
    path = [ pkgs.git pkgs.nix ];
    preStart = ''
      cd /home/careem/.nix
      ${pkgs.nix}/bin/nix flake update --commit-lock-file
    '';
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
