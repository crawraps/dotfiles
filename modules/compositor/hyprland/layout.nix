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
    "float on, match:class pavucontrol"
    "float on, match:class file-roller"
    "float on, match:title ^(Media viewer)$"
    "float on, match:title ^(Volume Control)$"
    "float on, match:title ^(Picture-in-Picture)$"
    "idle_inhibit focus, match:class mpv"
    "idle_inhibit fullscreen, match:class firefox"
    "size 384 216, match:title ^(Picture-in-Picture)$"
    "rounding 0, match:title ^(Picture-in-Picture)$"
    "pin on, match:title ^(Picture-in-Picture)$"
    "move 100%-384 100%-216, match:title ^(Picture-in-Picture)$"
    "size 800 600, match:title ^(Volume Control)$"
    "move 75 44%, match:title ^(Volume Control)$"
    "opaque on, match:class firefox-nightly"
    "opaque on, match:class zen-twilight"
    "no_shadow 0, match:class firefox-nightly"
    "no_shadow 0, match:class zen-twilight"
    "opacity 0.999, match:class obsidian"
    "opaque on, match:class thunderbird"
    "float on, match:class thunderbird, match:title ^(Write:)$"
    "border_color rgb(FFff00) rgb(880808), match:xwayland 1"
    "no_shadow 1, match:class .*"
    "border_size 0, match:float 0, match:workspace w[tv1]"
    "rounding 0, match:float 0, match:workspace w[tv1]"
    "border_size 0, match:float 0, match:workspace f[1]"
    "rounding 0, match:float 0, match:workspace f[1]"
    "float on, match:class imv"
    "float on, match:title wiremix"
    "float on, match:title CWC-Launcher-Terminal.*"
  ];

  layerrule = [
    "blur on, match:namespace sherlock"
    "ignore_alpha 0.1, match:namespace sherlock"
    "blur on, match:namespace ^(cwc_).*"
    "ignore_alpha 0.2, match:namespace ^(cwc_).*"
    "no_anim on, match:namespace ^(cwc_launcher).*"
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
