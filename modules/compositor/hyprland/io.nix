{
  # monitor
  monitor = [
    "HDMI-A-1,3840x2160@60,0x0,1.25"
    "eDP-2,2560x1600@165.02,3072x448,1.25"
  ];

  input = {
    kb_layout = "us,ru";
    numlock_by_default = true;

    follow_mouse = 1;
    sensitivity = 0;

    scroll_factor = 2.6;

    touchpad = {
      natural_scroll = true;
    };
  };

  gestures = {
    workspace_swipe_create_new = true;
  };
}
