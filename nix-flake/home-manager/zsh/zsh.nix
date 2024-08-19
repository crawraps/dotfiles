{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = import ./aliases.nix;
    sessionVariables = import ./variables.nix;

    history.size = 1000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      if [[ -z $IN_NIX_SHELL ]]; then
        export PROMPT=' %/: '
      else
        export PROMPT='%F{12}%~:%f '
      fi
    '';

    loginExtra = "Hyprland";

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
