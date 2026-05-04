{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.security; in
lib.mkIf cfg {
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]);
    settings = {};
  };

  programs.gpg = {
    enable = true;
    mutableTrust = true;
    mutableKeys = true;
  };
}