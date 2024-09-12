{ pkgs, ... }:
let
  username = "careem";
in {

  imports = [
    ./git.nix
    ./cursor.nix
    ./gtk.nix
    ./kitty.nix
    ./neovim.nix
    ./htop.nix
    ./yazi/yazi.nix
    ./zsh/zsh.nix
    ./wallpapers/wallpaper.nix
    ./executables/executables.nix
    ./hyprland/hyprland.nix
    ./firefox/firefox.nix
    ./config/config.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [
      bun
      playerctl
      dart-sass
      nodejs_22
      android-tools
      fd
      qbittorrent-qt5
      flavours
      wallust
      obs-studio
      hyprpicker
    ];
  };
}
