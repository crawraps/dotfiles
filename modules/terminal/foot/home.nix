{ preferences, lib, pkgs, ... }:

let
  cfg = preferences.modules.terminal;
  footPatched = pkgs.foot.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./patches/no-bg-effect-unless-blur.patch
    ];
  });
in
lib.mkIf cfg.foot {
  programs.foot = {
    enable = true;
    server.enable = true;
    package = footPatched;
  };

  xdg.configFile."foot/foot.ini".text = ''
    include=~/.config/dynamic-colors/foot.ini

    [main]
    font=Kode Mono:size=11

    [bell]
    system=no

    [mouse]
    hide-when-typing=yes
  '';

  xdg.desktopEntries = {
    foot = {
      name = "Foot";
      exec = "footclient";
      terminal = false;
      icon = ./assets/pictures/terminal.svg;
      categories = [ "System" "TerminalEmulator" ];
      comment = "footclient";
      type = "Application";
    };
  };
}