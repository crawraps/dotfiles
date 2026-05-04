{ pkgs, lib, preferences, ... }:
let cfg = preferences.modules.bootloader; in
lib.mkIf cfg {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernelParams = [ "quiet" "usbcore.autosuspend=-1" ];
  };

  environment.systemPackages = with pkgs; [ refind efibootmgr ];
}