{
  general = {
    layout = "workspacelayout";
    gaps_in = 5;
    gaps_out = 7;
    border_size = 0;
    no_border_on_floating = true;
    resize_on_border = true;
  };

  decoration = {
    rounding = 8;
    active_opacity = 1.0;
    inactive_opacity = 0.8;

    blur = {
      enabled = true;
      size = 4;
      passes = 5;
      new_optimizations = true;
      noise = 0;
      brightness = 1;
    };

    blurls = [
      "lockscreen"
      "wofi"
      "notifications"
      "top-bar"
    ];

    drop_shadow = "false";
    dim_inactive = "false";
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
    ];
  };
}
