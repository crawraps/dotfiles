{ preferences, lib, ... }:

let cfg = preferences.modules.widgets; in
{
  imports = []
    ++ lib.optionals cfg.qs [ ./qs/home.nix ]
    ++ lib.optionals cfg.ags [ ./ags/home.nix ]
    ++ lib.optionals cfg.sherlock [ ./sherlock/home.nix ];
}