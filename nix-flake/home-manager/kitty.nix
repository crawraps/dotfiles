{ pkgs, config, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "Kode Mono";
      size = 11;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = "0.001";
      enable_audio_bell = "no";
      window_padding_width = "4 4";
      confirm_os_window_close = "0";
      background_opacity = "0.5";
      dynamic_background_opacity = "no";
      allow_remote_control = "socket";
      listen_on = "unix:@kitty";
      map = "kitty_mod+enter new_os_window_with_cwd";
    };

    extraConfig = ''
      include ./colors.conf
    '';
  };
}
