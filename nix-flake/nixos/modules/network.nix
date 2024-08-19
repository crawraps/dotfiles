{
  networking = {
    nameservers = [ "8.8.8.8" ];

    networkmanager = {
      enable = true;
      dns = "none";
    };
  };
}
