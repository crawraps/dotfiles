{ pkgs, ... }: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 12;
    };
  };
}
