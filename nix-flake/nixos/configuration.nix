{ inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  networking.hostName = "nixos";

  time.timeZone = "Asia/Tbilisi";

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";

  # Collect month old garbage every week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
