{ preferences }: let
  inherit (preferences.modules.compositor) hyprland niri;
in {
  XDG_SESSION_TYPE = "wayland";
  XDG_CURRENT_DESKTOP = if niri then "niri" else "Hyprland";
  XDG_SESSION_DESKTOP = if niri then "niri" else "Hyprland";
  QT_QPA_PLATFORM = "wayland";
  GDK_BACKEND = "wayland";

  XDG_CONFIG_HOME = "$HOME/.config";
  XDG_DATA_HOME = "$HOME/.local/share";
  XDG_DATA_DIRS = "$HOME/.nix-profile/share/applications:$XDG_DATA_DIRS";
  WALLPAPERS = "$HOME/images/wallpapers";
  CACHE = "$HOME/.cache";
  PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";

  XDG_PICTURES_DIR = "$HOME/images";
  GRIM_DEFAULT_DIR = "$HOME/images/screenshots";

  LESSHISTFILE = "$HOME/.cache/less/history";

  PATH = "$HOME/.local/bin:$HOME/.local/packages/bin:$PATH";
}