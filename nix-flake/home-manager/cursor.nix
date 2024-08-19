{ pkgs, ... }: {
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    size = 16;
    package = pkgs.bibata-cursors;
  };
}
