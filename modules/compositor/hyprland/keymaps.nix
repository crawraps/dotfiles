{ lib, term, ... }:

let
  mod = "SUPER";

  # bind with no flags
  b = key: disp: { _args = [ key (lib.generators.mkLuaInline disp) ]; };
  # bind with flags
  bf = key: disp: flags: { _args = [ key (lib.generators.mkLuaInline disp) flags ]; };

  workspaceBinds = lib.concatMap (i:
    let key = toString (if i == 10 then 0 else i); in [
      (b  "${mod} + ${key}"         ''hl.dsp.focus({ workspace = ${toString i} })'')
      (b  "${mod} + SHIFT + ${key}" ''hl.dsp.window.move({ workspace = ${toString i}, follow = false })'')
    ]
  ) (lib.range 1 10);
in
{
  bind = [
    # basic apps
    (b "${mod} + Return"  ''hl.dsp.exec_cmd("${term}")'')
    (b "${mod} + D"       ''hl.dsp.exec_cmd("toggle-launcher")'')
    (b "${mod} + N"       ''hl.dsp.exec_cmd("ags -q && ags")'')

    # extra keys
    (bf "XF86AudioRaiseVolume"   ''hl.dsp.exec_cmd("pamixer -i 5")''                          { locked = true; repeating = true; })
    (bf "XF86AudioLowerVolume"   ''hl.dsp.exec_cmd("pamixer -d 5")''                          { locked = true; repeating = true; })
    (bf "XF86AudioMute"          ''hl.dsp.exec_cmd("pamixer -t")''                            { locked = true; })
    (bf "XF86AudioMicMute"       ''hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle")'' { locked = true; })
    (b  "Insert"                ''hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle")'')
    (bf "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl -d nvidia_0 -s -e set 5%-")'' { locked = true; repeating = true; })
    (bf "XF86MonBrightnessUp"   ''hl.dsp.exec_cmd("brightnessctl -d nvidia_0 -s -e set 5%+")'' { locked = true; repeating = true; })
    (b  "Print"                 ''hl.dsp.exec_cmd("hyprquickshot")'')

    # player management
    (b "${mod} + code:60" ''hl.dsp.exec_cmd("playerctl next")'')
    (b "${mod} + code:59" ''hl.dsp.exec_cmd("playerctl previous")'')
    (b "${mod} + M"       ''hl.dsp.exec_cmd("playerctl play-pause")'')

    # window management
    (b "${mod} + SHIFT + E" ''hl.dsp.exit()'')
    (b "${mod} + SHIFT + Q" ''hl.dsp.window.close()'')
    (b "${mod} + F"         ''hl.dsp.window.fullscreen()'')
    (b "${mod} + Space"     ''hl.dsp.window.float()'')
    (b "${mod} + P"         ''hl.dsp.window.pseudo()'')
    (b "${mod} + P"         ''hl.dsp.window.pin()'')

    # focus
    (b "${mod} + H" ''hl.dsp.focus({ direction = "l" })'')
    (b "${mod} + L" ''hl.dsp.focus({ direction = "r" })'')
    (b "${mod} + K" ''hl.dsp.focus({ direction = "u" })'')
    (b "${mod} + J" ''hl.dsp.focus({ direction = "d" })'')

    # move window
    (b "${mod} + SHIFT + H" ''hl.dsp.window.move({ direction = "l" })'')
    (b "${mod} + SHIFT + L" ''hl.dsp.window.move({ direction = "r" })'')
    (b "${mod} + SHIFT + K" ''hl.dsp.window.move({ direction = "u" })'')
    (b "${mod} + SHIFT + J" ''hl.dsp.window.move({ direction = "d" })'')
  ] ++ workspaceBinds ++ [
    # misc binds
    (b "${mod} + E"         ''hl.dsp.exec_cmd("workflow default")'')
    (b "${mod} + T"         ''hl.dsp.exec_cmd("work-timer toggle")'')
    (b "${mod} + SHIFT + R" ''hl.dsp.exec_cmd("voxtype-toggle")'')
    (b "${mod} + R"         ''hl.dsp.exec_cmd("voxtype record start")'')
    (bf "${mod} + R"        ''hl.dsp.exec_cmd("voxtype record stop")'' { release = true; })
    (b "${mod} + Tab"       ''hl.dsp.exec_cmd("hyprctl switchxkblayout all next")'')

    # mouse
    (bf "${mod} + mouse:272" ''hl.dsp.window.drag()''   { mouse = true; })
    (bf "${mod} + Control_L" ''hl.dsp.window.drag()''   { mouse = true; })
    (bf "${mod} + mouse:273" ''hl.dsp.window.resize()'' { mouse = true; })
    (bf "${mod} + ALT_L"     ''hl.dsp.window.resize()'' { mouse = true; })
  ];
}