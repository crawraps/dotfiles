{ ... }: {
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  xdg.configFile.ags = {
    source = ./ags;
  };

  xdg.configFile.wallust = {
    source = ./wallust;
  };

  xdg.configFile.anyrun = {
    source = ./anyrun;
    recursive = true;
  };

  xdg.configFile.wireplumber = {
    source = ./wireplumber;
    recursive = true;
  };
}
