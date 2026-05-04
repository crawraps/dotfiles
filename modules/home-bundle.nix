{ pkgs, pkgs-stable, inputs, system, preferences, lib, config, ... }:
let inherit (preferences.user) name; in {
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./agents/home.nix
    ./appearance/home.nix
    ./bluetooth/home.nix
    ./browser/home.nix
    ./compositor/home.nix
    ./development/home.nix
    ./direnv/home.nix
    ./email/home.nix
    ./environment/home.nix
    ./git/home.nix
    ./kde-connect/home.nix
    ./media/home.nix
    ./mongodb/home.nix
    ./text-editor/home.nix
    ./productivity/home.nix
    ./screenshots/home.nix
    ./security/home.nix
    ./system-maintenance/home.nix
    ./terminal/home.nix
    ./utilities/home.nix
    ./widgets/home.nix
    ./file-manager/home.nix
  ];

  home = {
    username = name;
    homeDirectory = "/home/${name}";
    stateVersion = preferences.system.stateVersion;
  };
}
