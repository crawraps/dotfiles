{ pkgs, preferences, lib, ... }:
let cfg = preferences.modules.agents; in
{
  home.packages = with pkgs; []
    ++ lib.optionals cfg.opencode [ opencode ]
    ++ lib.optionals cfg.claude [ claude-code ]
    ++ lib.optionals cfg.oh-my-pi [ (import ./omp-package.nix { inherit pkgs lib; }) ];
}