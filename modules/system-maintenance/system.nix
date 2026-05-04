{ lib, preferences, ... }:

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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}