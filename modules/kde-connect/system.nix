{ config, lib, preferences, ... }:

let cfg = preferences.modules.kdeConnect; in
lib.mkIf cfg {
  networking.firewall.allowedTCPPorts = [ 1714 1715 1716 1717 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1729 1730 1731 1732 ];
  networking.firewall.allowedUDPPorts = [ 1714 1715 1716 1717 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1729 1730 1731 1732 ];
}