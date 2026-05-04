{ name, ... }: {
  bind = [
    # basic apps
    "$mod, Return, exec, $term"
    "$mod, d, exec, $launcher"
    "$mod, n, exec, ags -q && ags"

    # extra keys
    ", XF86AudioRaiseVolume, exec, pamixer -i 5"
    ", XF86AudioLowerVolume, exec, pamixer -d 5"
    ", XF86AudioMute, exec, pamixer -t"
    ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ", Insert, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ", XF86MonBrightnessDown, exec, brightnessctl -d nvidia_0 -s -e set 5%-"
    ", XF86MonBrightnessUp, exec, brightnessctl -d nvidia_0 -s -e set 5%+"
    ", Print, exec, hyprquickshot"

    # player managment
    "$mod, 60, exec, playerctl next"
    "$mod, 59, exec, playerctl previous"
    "$mod, m, exec, playerctl play-pause"

    # window managment
    "$mod SHIFT, E, exit,"
    "$mod SHIFT, Q, killactive,"
    "$mod, F, fullscreen,"
    "$mod, Space, togglefloating,"
    "$mod, P, pseudo,"
    "$mod, S, togglesplit,"

    "$mod, H, movefocus, l"
    "$mod, L, movefocus, r"
    "$mod, K, movefocus, u"
    "$mod, J, movefocus, d"

    "$mod SHIFT, H, movewindow, l"
    "$mod SHIFT, L, movewindow, r"
    "$mod SHIFT, K, movewindow, u"
    "$mod SHIFT, J, movewindow, d"

    "$mod, p, pin"

    "$mod, $1, workspace, 1"
    "$mod, $2, workspace, 2"
    "$mod, $3, workspace, 3"
    "$mod, $4, workspace, 4"
    "$mod, $5, workspace, 5"
    "$mod, $6, workspace, 6"
    "$mod, $7, workspace, 7"
    "$mod, $8, workspace, 8"
    "$mod, $9, workspace, 9"
    "$mod, $0, workspace, 10"

    "$mod SHIFT, $1, movetoworkspacesilent, 1"
    "$mod SHIFT, $2, movetoworkspacesilent, 2"
    "$mod SHIFT, $3, movetoworkspacesilent, 3"
    "$mod SHIFT, $4, movetoworkspacesilent, 4"
    "$mod SHIFT, $5, movetoworkspacesilent, 5"
    "$mod SHIFT, $6, movetoworkspacesilent, 6"
    "$mod SHIFT, $7, movetoworkspacesilent, 7"
    "$mod SHIFT, $8, movetoworkspacesilent, 8"
    "$mod SHIFT, $9, movetoworkspacesilent, 9"
    "$mod SHIFT, $0, movetoworkspacesilent, 10"

    "$mod, E, exec, workflow default"
    "$mod, t, exec, work-timer toggle"

    "$mod, tab, exec, hyprctl switchxkblayout all next "
  ];

  bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, Control_L, movewindow"
    "$mod, mouse:273, resizewindow"
    "$mod, ALT_L, resizewindow"
  ];
}
