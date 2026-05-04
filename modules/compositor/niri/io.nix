{
  outputs = {
    "HDMI-A-1" = {
      mode = {
        width = 3840;
        height = 2160;
        refresh = 60.0;
      };
      scale = 1.25;
      position = { x = 0; y = 0; };
    };
    "eDP-2" = {
      mode = {
        width = 2560;
        height = 1600;
        refresh = 165.02;
      };
      scale = 1.25;
      position = { x = 3072; y = 448; };
    };
  };

  input = {
    keyboard.xkb.layout = "us,ru";
    touchpad.natural-scroll = true;
    focus-follows-mouse.enable = true;
  };
}
