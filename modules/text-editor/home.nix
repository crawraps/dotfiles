{ preferences, lib, ... }:

let cfg = preferences.modules.text-editor; in
{
  imports = []
    ++ lib.optionals (cfg.neovim or false) [ ./neovim/home.nix ];
}