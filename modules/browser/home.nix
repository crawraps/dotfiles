{ inputs, preferences, lib, ... }:

let
  cfg = preferences.modules.browser;

  browser-desktop =
    if cfg.zen then "zen.desktop"
    else if cfg.firefox then "firefox.desktop"
    else if cfg.chromium then "chromium.desktop"
    else "zen.desktop";
in
{
  imports = []
    ++ lib.optionals cfg.zen [ ./zen/home.nix ]
    ++ lib.optionals cfg.firefox [ ./firefox/home.nix ]
    ++ lib.optionals cfg.chromium [ ./chromium/home.nix ];

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "x-scheme-handler/http" = browser-desktop;
      "x-scheme-handler/https" = browser-desktop;
      "text/html" = browser-desktop;
      "application/xhtml+xml" = browser-desktop;

      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";

      "video/mp4" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";

      "application/pdf" = browser-desktop;
      "inode/directory" = "yazi.desktop";
    };
  };

  wayland.windowManager.hyprland.settings = lib.mkIf preferences.modules.compositor.hyprland {
    windowrule = [
      "float on, match:title ^(Picture-in-Picture)$"
      "size 384 216, match:title ^(Picture-in-Picture)$"
      "rounding 0, match:title ^(Picture-in-Picture)$"
      "pin on, match:title ^(Picture-in-Picture)$"
      "move 100%-384 100%-216, match:title ^(Picture-in-Picture)$"
    ];
  };
}