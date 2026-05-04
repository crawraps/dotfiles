{ preferences, lib, ... }:

let cfg = preferences.modules.terminal; in
{
  imports = []
    ++ lib.optionals cfg.foot [ ./foot/home.nix ]
    ++ lib.optionals cfg.kitty [ ./kitty/home.nix ];
}