{ pkgs, lib, preferences, ... }:

let cfg = preferences.modules.docker; in
lib.mkIf cfg {
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = true;
    };
  };
}