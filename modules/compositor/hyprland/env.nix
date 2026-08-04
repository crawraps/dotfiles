{
  env = [
    { _args = [ "XDG_CURRENT_DESKTOP" "Hyprland" ]; }
    { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
    { _args = [ "XDG_SESSION_DESKTOP" "Hyprland" ]; }
    { _args = [ "QT_QPA_PLATFORM" "wayland" ]; }
  ];

  config = {
    debug = {
      disable_logs = false;
      disable_time = false;
    };
  };
}