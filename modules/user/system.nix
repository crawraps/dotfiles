{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.user;
  inherit (preferences.user) name extraGroups;
in
lib.mkIf cfg {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.${name} = {
      isNormalUser = true;
      inherit extraGroups;
    };
  };

  services.getty.autologinUser = name;

  systemd.tmpfiles.rules = [
    "d /home/${name}/.local/share/gnupg 0700 ${name} users -"
  ];
}