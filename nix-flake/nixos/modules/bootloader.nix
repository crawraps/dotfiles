{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_10;
  boot.kernelParams = [
    "quiet"
  ];

  # Specific hardware fix, you probably don't need it
  boot.kernelPatches = [
    {
      name = "AMD sound fix";
      patch = ./patches/amd-sound.patch;
    }
  ];
}
