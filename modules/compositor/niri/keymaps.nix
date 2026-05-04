{ actions, term }:
with actions; {
  # Basic apps
  "Mod+Return".action = spawn term;
  "Mod+D".action = spawn [ "toggle-launcher" ];

  # Media keys
  "XF86AudioRaiseVolume".action = spawn [ "pamixer" "-i" "5" ];
  "XF86AudioLowerVolume".action = spawn [ "pamixer" "-d" "5" ];
  "XF86AudioMute".action = spawn [ "pamixer" "-t" ];
  "XF86AudioMicMute".action = spawn [ "pactl" "set-source-mute" "@DEFAULT_SOURCE@" "toggle" ];
  "Insert".action = spawn [ "pactl" "set-source-mute" "@DEFAULT_SOURCE@" "toggle" ];
  "XF86MonBrightnessDown".action = spawn [ "brightnessctl" "-d" "nvidia_0" "-s" "-e" "set" "5%-" ];
  "XF86MonBrightnessUp".action = spawn [ "brightnessctl" "-d" "nvidia_0" "-s" "-e" "set" "5%+" ];
  "Print".action.screenshot = [];

  # Player management
  "Mod+Period".action = spawn [ "playerctl" "next" ];
  "Mod+Comma".action = spawn [ "playerctl" "previous" ];
  "Mod+M".action = spawn [ "playerctl" "play-pause" ];

  # Window management
  "Mod+Shift+E".action = quit;
  "Mod+Shift+Q".action = close-window;
  "Mod+F".action = fullscreen-window;

  # Column/window navigation (vim-style)
  "Mod+H".action = focus-column-left;
  "Mod+L".action = focus-column-right;
  "Mod+K".action = focus-window-up;
  "Mod+J".action = focus-window-down;

  # Move columns/windows
  "Mod+Shift+H".action = move-column-left;
  "Mod+Shift+L".action = move-column-right;
  "Mod+Shift+K".action = move-window-up;
  "Mod+Shift+J".action = move-window-down;

  # Column management (niri-specific)
  "Mod+BracketLeft".action = consume-window-into-column;
  "Mod+BracketRight".action = expel-window-from-column;
  "Mod+C".action = center-column;
  "Mod+Minus".action = set-column-width "-10%";
  "Mod+Equal".action = set-column-width "+10%";

  # Workspaces
  "Mod+1".action = focus-workspace 1;
  "Mod+2".action = focus-workspace 2;
  "Mod+3".action = focus-workspace 3;
  "Mod+4".action = focus-workspace 4;
  "Mod+5".action = focus-workspace 5;
  "Mod+6".action = focus-workspace 6;
  "Mod+7".action = focus-workspace 7;
  "Mod+8".action = focus-workspace 8;
  "Mod+9".action = focus-workspace 9;

  "Mod+Shift+1".action.move-column-to-workspace = 1;
  "Mod+Shift+2".action.move-column-to-workspace = 2;
  "Mod+Shift+3".action.move-column-to-workspace = 3;
  "Mod+Shift+4".action.move-column-to-workspace = 4;
  "Mod+Shift+5".action.move-column-to-workspace = 5;
  "Mod+Shift+6".action.move-column-to-workspace = 6;
  "Mod+Shift+7".action.move-column-to-workspace = 7;
  "Mod+Shift+8".action.move-column-to-workspace = 8;
  "Mod+Shift+9".action.move-column-to-workspace = 9;

  # Keyboard layout switch
  "Mod+Tab".action = switch-layout "next";

  # Custom scripts
  "Mod+E".action = spawn [ "workflow" "default" ];
  "Mod+T".action = spawn [ "work-timer" "toggle" ];
}
