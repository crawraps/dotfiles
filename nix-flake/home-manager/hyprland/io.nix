{
  # monitor
  monitor = [
    "eDP-1,2560x1600@60,0x560,1.33"
    "HDMI-A-1,3840x2160@60,-3072x0,1.25"
  ];

  # keyboard
  input = {
    kb_layout = "us,ru";
    kb_options = "grp:alt_shift_toggle";
    numlock_by_default = true;

    follow_mouse = 1;
    sensitivity = 0;

    touchpad = {
      natural_scroll = true;
    };
  };

  gestures = {
    workspace_swipe = true;
    workspace_swipe_create_new = true;
  };
}
