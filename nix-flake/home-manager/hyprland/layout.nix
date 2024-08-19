{
  dwindle = {
    "no_gaps_when_only" = true;
    "pseudotile" = true;
    "preserve_split" = true;
    "force_split" = 2;
  };

  windowrule = [
    "float, file_progress"
    "float, confirm"
    "float, dialog"
    "float, download"
    "float, notification"
    "float, error"
    "float, splash"
    "float, confirmreset"
    "float, title:Open File"
    "float, title:branchdialog"
    "float, feh"
    "float, pavucontrol"
    "float, file-roller"
    "float, title:^(Media viewer)$"
    "float, title:^(Volume Control)$"
    "float, title:^(Picture-in-Picture)$"
    "idleinhibit focus, mpv"
    "idleinhibit fullscreen, firefox"
    "size 384 216, title:^(Picture-in-Picture)$"
    "rounding 0, title:^(Picture-in-Picture)$"
    "pin, title:^(Picture-in-Picture)$"
    "move 100%-384 100%-216, title:^(Picture-in-Picture)$"
    "size 800 600, title:^(Volume Control)$"
    "move 75 44%, title:^(Volume Control)$"
    "opaque, firefox"
    "opacity 0.999, obsidian"
  ];

  windowrulev2 = [
    "bordercolor rgb(FFff00) rgb(880808), xwayland:1"
  ];

  layerrule = [
    "blur, top-bar"
    "ignorealpha 0.2, top-bar"
    "blur, sliders"
    "ignorealpha 0.2, sliders"
    "blur, notifications"
    "ignorealpha 0.2, notifications"
    "blur, power-menu"
    "blur, anyrun"
    "ignorealpha 0, anyrun"
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
