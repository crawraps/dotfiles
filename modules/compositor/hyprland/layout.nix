{
  dwindle = {
    pseudotile = true;
    preserve_split = true;
    force_split = 2;
  };

  master = {
    orientation = "center";
    slave_count_for_center_master = 3;
    mfact = 0.5;
    smart_resizing = true;
  };

  workspace = [
    "w[tv1], gapsout:0, gapsin:0"
    "f[1], gapsout:0, gapsin:0"
  ];

  windowrule = [
    "float on, match:title file_progress"
    "float on, match:title confirm"
    "float on, match:title dialog"
    "float on, match:title download"
    "float on, match:title notification"
    "float on, match:title error"
    "float on, match:title splash"
    "float on, match:class confirmreset"
    "float on, match:title Open File"
    "float on, match:title branchdialog"
    "float on, match:class file-roller"
    "float on, match:title ^(Media viewer)$"
    "border_color rgb(FFff00) rgb(880808), match:xwayland 1"
    "no_shadow 1, match:class .*"
    "border_size 0, match:float 0, match:workspace w[tv1]"
    "rounding 0, match:float 0, match:workspace w[tv1]"
    "border_size 0, match:float 0, match:workspace f[1]"
    "rounding 0, match:float 0, match:workspace f[1]"
  ];

  misc = {
    disable_splash_rendering = true;
    mouse_move_enables_dpms = true;
    disable_hyprland_logo = true;
  };

  xwayland = {
    force_zero_scaling = true;
  };
}
