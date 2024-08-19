{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.careem = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "careem";

  # Enable doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  security.doas.extraRules = [{
      users = [ "careem" ];
      keepEnv = true;
      persist = true;
  }];
}
