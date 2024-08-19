{ config, ... }: {
  home.file = {
    paper = {
      source = ./scripts/paper;
      target = ".local/bin/paper";
      executable = true;
    };

    dye = {
      source = ./scripts/dye;
      target = ".local/bin/dye";
      executable = true;
    };
  };
}