{ preferences, lib, ... }:

let cfg = preferences.modules.direnv; in
lib.mkIf cfg {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;

    stdlib = ''
      use_nix_auto() {
        if [[ -f flake.nix ]]; then
          use flake
        elif [[ -f shell.nix ]]; then
          use nix
        elif [[ -f default.nix ]]; then
          use nix
        fi
      }
    '';
  };
}