{
  bind = [
    # basic apps
    "$mod, Return, exec, kitty -1"
    "$mod, d, exec, killall anyrun || anyrun"
    "$mod, n, exec, ags -q && ags"

    # extra keys
    ", XF86AudioRaiseVolume, exec, pamixer -i 5"
    ", XF86AudioLowerVolume, exec, pamixer -d 5"
    ", XF86AudioMute, exec, pamixer -t"
    ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ", XF86MonBrightnessDown, exec, brightnessctl -d amdgpu_bl1 -s -e set 5%-"
    ", XF86MonBrightnessUp, exec, brightnessctl -d amdgpu_bl1 -s -e set 5%+"
    '', F12, exec, IMG=$GRIM_DEFAULT_DIR/$(date +%Y-%m-%d_%H-%m-%s).png && grim $IMG && wl-copy < $IMG && notify-send -u normal -t 3000 -i /home/careem/.nix-profile/share/icons/Reversal/apps/scalable/applets-screenshooter.svg "Screen captured" "New screenshot copied to clipboard and saved as $IMG"''
    ''$mod, F12, exec, IMG=$GRIM_DEFAULT_DIR/$(date +%Y-%m-%d_%H-%m-%s).png && grim -g "$(slurp)" $IMG && wl-copy < $IMG''

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

    # "$mod, e, submap, power-menu"
  ];

  bindm = [
    "$mod, Alt_L, resizewindow"
  ];

  # power managment
  #
  # "$pm-s" = "poweroff";
  # "$pm-r" = "reboot";
  # "$pm-l" = "hyprctl dispatch exit && loginctl --kill-user `whoami`";
  # "$pm-o" = "$locker";
  #
  # submap = {
  #   name = "power-menu";
  #
  #   bindr = [
  #     ", s, exec, $pm-s"
  #     ", r, exec, $pm-r"
  #     ", l, exec, $pm-l"
  #     ", o, exec, $pm-o"
  #   ];
  #
  #   bind = [
  #     ", catchall, exec,"
  #     ", escape, submap, reset"
  #     "$mod, e, submap, reset"
  #   ];
  # };
}
