{ foot, kitty, ... }: let
  flakeDir = "~/.nix";
in {
  sudo = "doas";
  rb = "doas nixos-rebuild switch --flake ${flakeDir}";
  upd = "doas nix flake update --flake ${flakeDir}";
  upg = "doas nixos-rebuild switch --upgrade --flake ${flakeDir}";

  ll = "ls -l";
  v = "nvim";
  ff = "fastfetch";
  c = "clear";
  cwc = "quickshell -c cwc";
  ssh = if kitty then "kitty +kitten ssh" else "TERM=xterm-256color ssh";
}