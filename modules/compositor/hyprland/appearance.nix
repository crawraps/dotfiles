{
  config = {
    general = {
      gaps_in     = 5;
      gaps_out    = 7;
      border_size = 0;
    };

    decoration = {
      rounding         = 8;
      active_opacity   = 1.0;
      inactive_opacity = 0.8;
      dim_inactive     = false;

      blur = {
        enabled           = true;
        size              = 8;
        passes            = 4;
        new_optimizations = true;
        noise             = 0.04;
        brightness        = 1;
      };

      shadow = {
        enabled = false;
      };
    };

    animations = {
      enabled = true;
    };
  };

  curve = [
    { _args = [ "smoothIn"     { type = "bezier"; points = [ [ 0.25 1 ] [ 0.5 1 ]  ]; } ]; }
    { _args = [ "easeOutCubic" { type = "bezier"; points = [ [ 0.33 1 ] [ 0.68 1 ] ]; } ]; }
    { _args = [ "easeInCubic"  { type = "bezier"; points = [ [ 0.32 0 ] [ 0.67 0 ] ]; } ]; }
  ];

  animation = [
    { leaf = "windowsOut"; enabled = true; speed = 4; bezier = "easeInCubic";  style = "slide";        }
    { leaf = "fade";       enabled = true; speed = 8; bezier = "smoothIn";                              }
    { leaf = "fadeDim";    enabled = true; speed = 8; bezier = "smoothIn";                              }
    { leaf = "workspaces"; enabled = true; speed = 2; bezier = "easeOutCubic"; style = "slidefade 20%"; }
    { leaf = "layersIn";   enabled = true; speed = 2; bezier = "easeOutCubic"; style = "slide";        }
    { leaf = "layersOut";  enabled = true; speed = 2; bezier = "easeInCubic";  style = "slide";        }
  ];
}