{ preferences, ... }:
{
  imports = [ ./hardware ./bundle.nix ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = preferences.system.stateVersion;
}