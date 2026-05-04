{ lib, preferences, ... }:

let cfg = preferences.modules.env; in
lib.mkIf (cfg.zsh or (cfg == true)) {
  environment = {
    variables = {
      EDITOR = "nvim";
      RANGER_LOAD_DEFAULT_RC = "FALSE";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GSETTINGS_BACKEND = "keyfile";

      ANDROID_USER_HOME = "$HOME/.local/share/android";
      GRADLE_USER_HOME = "$HOME/.local/share/gradle";
      GNUPGHOME = "$HOME/.local/share/gnupg";
      NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
      NPM_CONFIG_CACHE = "$HOME/.cache/npm";
      NPM_CONFIG_PREFIX = "$HOME/.local/share/npm";
      BUN_INSTALL_DIR = "$HOME/.local/share/bun";
      BUNDLE_USER_HOME  = "$HOME/.local/share/bundle";
      CUDA_CACHE_PATH = "$HOME/.cache/nv";
      PLATFORMIO_CORE_DIR = "$HOME/.local/share/platformio";
    };

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };
}