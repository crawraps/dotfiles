{ pkgs, lib, preferences, ... }:

let cfg = preferences.modules.ld; in
lib.mkIf cfg {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
}