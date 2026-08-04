{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.voxtype;
  voxtype = pkgs.voxtype.override { onnxSupport = true; };
in
lib.mkIf cfg {
  environment.systemPackages = [
    voxtype
    pkgs.wtype
    pkgs.wl-clipboard
    pkgs.libnotify
    pkgs.playerctl
  ];

  users.users.${preferences.user.name}.extraGroups = [ "input" ];
}