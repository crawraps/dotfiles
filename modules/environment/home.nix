{ config, pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.env;
  inherit (preferences.modules.compositor) hyprland niri;
  inherit (preferences.modules.terminal) foot kitty;
  inherit (preferences.user) name;
in
lib.mkIf cfg.zsh {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = import ./zsh/aliases.nix { inherit foot kitty; };
    sessionVariables = import ./zsh/variables.nix { inherit preferences; };

    history.size = 1000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initContent = ''
      source ${config.xdg.configHome}/zsh/.secrets

      if [[ -z $IN_NIX_SHELL ]]; then
        export PROMPT=' %/: '
      else
        export PROMPT='%F{12}%~:%f '
      fi

      theme < $XDG_CONFIG_HOME/colors/terminal
      TRAPUSR1() {
        theme < $XDG_CONFIG_HOME/colors/terminal
      }
    '';

    loginExtra = let
      startCmd = if niri then "niri" else "start-hyprland";
    in ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
        ${startCmd}
      fi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}