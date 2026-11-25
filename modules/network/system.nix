{ config, lib, preferences, self, ... }:

let cfg = preferences.modules.network; in
lib.mkIf cfg {
  networking = {
    hostName = preferences.system.hostname;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "no";
      FallbackDNS = [ "" ];
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
    authKeyFile = self + "/secrets/tailscale.key";
    extraUpFlags = [ "--accept-routes" ];
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
