{
  general = {
    layout = "dwindle";
    gaps_in = 5;
    gaps_out = 7;
    border_size = 1;
    no_border_on_floating = true;

    "col.inactive_border" = "$c-border";
    "col.active_border" = "$c-border-active";
  };

  decoration = {
    rounding = 8;
    active_opacity = 1.0;
    inactive_opacity = 0.8;

    blur = {
      enabled = true;
      size = 4;
      passes = 4;
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
      "overshot, 0.05, 0.9, 0.1, 1.05"
      "smoothOut, 0.36, 0, 0.66, -0.56"
      "smoothIn, 0.25, 1, 0.5, 1"
      "easeOutCubic, 0.33, 1, 0.68, 1"
      "easeInCubic, 0.32, 0, 0.67, 0"
      "easeInOutCubic, 0.65, 0, 0.35, 1"
      "lol, 0.68, -0.6, 0.32, 1.6"
      "jump, .19,1.23,.92,.97"
    ];

    animation = [
      "windowsIn, 1, 2, easeOutCubic, popin 80%"
      "windowsOut, 1, 4, easeInCubic, slide"
      "windowsMove, 1, 4, default"
      "fade, 1, 8, smoothIn"
      "fadeDim, 1, 8, smoothIn"
      "workspaces, 1, 2, easeOutCubic, slidefade 20%"
    ];
  };
}
