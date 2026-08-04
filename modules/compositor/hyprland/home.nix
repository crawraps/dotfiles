{ lib, pkgs, pkgs-stable, preferences, ... }:

let
  cfg = preferences.modules.compositor;
  inherit (preferences.modules.terminal) foot;
  term = if foot then "footclient" else "kitty -1";
in
lib.mkIf cfg.hyprland {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    sourceFirst = true;

    configType = "lua";

    settings = lib.mkMerge [
      (import ./appearance.nix)
      (import ./env.nix)
      (import ./peripherals.nix)
      (import ./layout.nix)
      (import ./keymaps.nix { inherit lib term; })
    ];

    extraLuaFiles = { };

    # Startup scripts
    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("bash -c '~/.local/bin/paper -g common'")
        ${lib.optionalString foot ''hl.exec_cmd("foot --server")''}
        ${lib.optionalString preferences.modules.widgets.qs ''hl.exec_cmd("quickshell -dn -c cwc")''}
        ${lib.optionalString preferences.modules.email ''hl.exec_cmd("protonmail-bridge --noninteractive")''}
      end)

      -- block submap: swallow all keys
      hl.define_submap("block", function()
        hl.bind("catchall", hl.dsp.no_op())
      end)
    '';
  };
}
