let
  flakeDir = "~/.nix";
in {
  sudo = "doas";
  rb = "doas nixos-rebuild switch --flake ${flakeDir}";
  upd = "doas nix flake update ${flakeDir}";
  upg = "doas nixos-rebuild switch --upgrade --flake ${flakeDir}";

  hms = "home-manager switch --flake ${flakeDir} -b backup";

  conf = "nvim ${flakeDir}/nixos/configuration.nix";
  pkgs = "nvim ${flakeDir}/nixos/packages.nix";

  mount-win = "doas mount /dev/nvme1n1p2 ~/mounted/windows";

  ll = "ls -l";
  v = "nvim";
  ff = "fastfetch";
  c = "clear";
  ssh = "kitty +kitten ssh";
}
