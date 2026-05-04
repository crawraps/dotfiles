{ lib, preferences, ... }:

let cfg = preferences.modules.keyboard; in
lib.mkIf cfg {
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "leftalt";
          leftalt = "layer(nav)";
        };
        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        };
      };
    };
  };
}