{
  config = {
    general = {
      layout = "dwindle";
    };

    dwindle = {
      preserve_split = true;
      force_split    = 2;
    };

    master = {
      orientation                   = "center";
      slave_count_for_center_master = 3;
      mfact                         = 0.7;
      smart_resizing                = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    misc = {
      disable_splash_rendering = true;
      mouse_move_enables_dpms  = true;
      disable_hyprland_logo    = true;
    };
  };

  workspace_rule = [
    { workspace = "w[tv1]"; gaps_out = 0; gaps_in = 0; }
    { workspace = "f[1]";   gaps_out = 0; gaps_in = 0; }
    { workspace = "m[1]";   layout = "master"; monitor = "HDMI-A-1"; default = true; }
  ];

  window_rule = [
    # float transient/modal windows spawned by other windows
    { match = { modal = true; }; float = true; }
    { match = { float = true; }; persistent_size = true; }
    { match = { xwayland = true; };              border_color = "rgb(FFff00) rgb(880808)"; }
    { match = { float = false; workspace = "w[tv1]"; }; border_size = 0; rounding = 0; }
    { match = { float = false; workspace = "f[1]"; };   border_size = 0; rounding = 0; }
  ];
}