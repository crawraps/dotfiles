{
  general = {
    layout = "master";
    gaps_in = 5;
    gaps_out = 7;
    border_size = 0;
  };

  decoration = {
    rounding = 8;
    active_opacity = 1.0;
    inactive_opacity = 0.8;
    dim_inactive = "false";

    blur = {
      enabled = true;
      size = 4;
      passes = 5;
      new_optimizations = true;
      noise = 0.04;
      brightness = 1;
    };

    shadow = {
      enabled = false;
      ignore_window = false;
    };
  };

  animations = {
    enabled = true;

    bezier = [
      "smoothIn, 0.25, 1, 0.5, 1"
      "easeOutCubic, 0.33, 1, 0.68, 1"
      "easeInCubic, 0.32, 0, 0.67, 0"
    ];

    animation = [
      # "windowsIn, 1, 2, easeOutCubic, popin 80%"
      "windowsOut, 1, 4, easeInCubic, slide"
      # "windowsMove, 1, 4, default"
      "fade, 1, 8, smoothIn"
      "fadeDim, 1, 8, smoothIn"
      "workspaces, 1, 2, easeOutCubic, slidefade 20%"
      "layersIn, 1, 2, easeOutCubic, slide"
      "layersOut, 1, 2, easeInCubic, slide"
    ];
  };
}
