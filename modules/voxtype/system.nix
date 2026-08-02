{ pkgs, inputs, system, preferences, lib, ... }:

let cfg = preferences.modules.voxtype; in
lib.mkIf cfg {
  environment.systemPackages = [
    inputs.voxtype.packages.${system}.vulkan
    pkgs.wtype
    pkgs.wl-clipboard
    pkgs.libnotify
    pkgs.playerctl
  ];

  users.users.${preferences.user.name}.extraGroups = [ "input" ];
}