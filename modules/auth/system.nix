{ lib, preferences, ... }:
let
  cfg = preferences.modules.auth;
  inherit (preferences.user) name;
in
lib.mkIf cfg {
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ name ];
      keepEnv = true;
      persist = true;
    }];
  };
}