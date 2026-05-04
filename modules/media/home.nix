{ pkgs, preferences, lib, ... }:

let cfg = preferences.modules.media; in
{
  imports = []
    ++ lib.optionals (builtins.isAttrs cfg && builtins.isAttrs cfg.sound) [ ./sound/home.nix ]
    ++ lib.optionals (builtins.isAttrs cfg && builtins.isAttrs cfg.video) [ ./video/home.nix ];
}