{ pkgs, inputs, system, preferences, lib, ... }:

let cfg = preferences.modules.utilities; in
lib.mkIf cfg {
  home.packages = with pkgs; [
    fd
    fastfetch
    jq
    playerctl
    translate-shell
    file
    tree
    wget
    ripgrep
    killall
    libnotify
    unzip
    zip
    ntfs3g
    wl-clipboard
    inputs.calc.packages.${system}.default
  ];
}