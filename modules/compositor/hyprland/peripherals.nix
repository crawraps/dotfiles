{
  monitor = [
    { output = "eDP-2";   mode = "highres"; position = "auto-right"; scale = 1.25; }
    { output = "HDMI-A-1"; mode = "highres"; position = "0x0";       scale = 1.25; }
  ];

  config = {
    input = {
      kb_layout          = "us,ru";
      numlock_by_default = true;
      follow_mouse       = 1;
      sensitivity        = 0;
      scroll_factor      = 2.6;
      touchpad = {
        natural_scroll = true;
      };
    };

    gestures = {
      workspace_swipe_create_new = true;
    };
  };
}