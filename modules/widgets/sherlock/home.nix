{ preferences, lib, ... }:

let cfg = preferences.modules.widgets; in
lib.mkIf cfg.sherlock {
  programs.sherlock = {
    enable = true;
    settings = {
      config = {
        default_apps = {
          browser = "zen";
          terminal = "footclient";
          calendar_client = "thunderbird";
          video_player = "mpv";
        };
        appearance = {
          width = 900;
          height = 600;
          anchor = "bottom";
          status_bar = false;
        };
        debug = {
          try_suppress_warnings = true;
          app_paths = [ "~/.nix-profile/share/applications" ];
        };
      };
      ignore = ''
        NixOS*
        NVIDIA*
      '';
      launchers = [
        {
          name = "App Launcher";
          alias = "app";
          type = "app_launcher";
          args = {};
          priority = 10;
          home = true;
        }
        {
          name = "Clipboard";
          type = "clipboard-execution";
          args = {
            capabilities = [
              "url"
              "colors.all"
              "calc.units"
            ];
          };
          priority = 2;
          home = true;
        }
        {
          name = "Calculator";
          type = "calculation";
          args = {
            capabilities = [
              "calc.math"
              "calc.units"
            ];
          };
          priority = 1;
          home = false;
        }
        {
          name = "Bookmarks";
          type = "bookmarks";
          alias = "bm";
          args = {
            icon = "sherlock-bookmark";
            icon_class = "reactive";
          };
          priority = 3;
          home = false;
        }
        {
          name = "Power Management";
          alias = "pm";
          type = "command";
          args = {
            commands = {
              Shutdown = {
                icon = "system-shutdown";
                exec = "systemctl poweroff";
                search_string = "Poweroff;Shutdown";
              };
              Sleep = {
                icon = "system-suspend";
                exec = "systemctl suspend";
                search_string = "Sleep";
              };
              Lock = {
                icon = "system-lock-screen";
                exec = "systemctl suspend & swaylock";
                search_string = "Lock Screen";
              };
              Reboot = {
                icon = "system-reboot";
                exec = "systemctl reboot";
                search_string = "reboot";
              };
            };
          };
          priority = 4;
        }
        {
          name = "Utilities";
          alias = "";
          type = "command";
          args = {
            commands = {
              "Color Picker" = {
                icon = "colorgrab";
                exec = "hyprpicker -a &";
                search_string = "colorpicker";
              };
            };
          };
          priority = 5;
        }
        {
          name = "Web Search";
          display_name = "Web Search";
          tag_start = "{keyword}";
          alias = "gg";
          type = "web_launcher";
          args = {
            search_engine = "https://search.brave.com/search?q={keyword}";
            icon = "google";
          };
          priority = 100;
        }
        {
          name = "Weather";
          type = "weather";
          args = {
            location = "tbilisi";
            update_interval = 60;
          };
          priority = 1;
          home = true;
          only_home = true;
          async = true;
          shortcut = false;
          spawn_focus = false;
        }
      ];
      style = builtins.readFile ./assets/style.css;
    };
  };

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    layerrule = [
      "blur on, match:namespace sherlock"
      "ignore_alpha 0.1, match:namespace sherlock"
    ];
  };
}