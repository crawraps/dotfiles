{ pkgs, lib, preferences, ... }:

let cfg = preferences.modules.waydroid; in
lib.mkIf cfg {
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  environment.systemPackages = [ pkgs.wl-clipboard ];
}