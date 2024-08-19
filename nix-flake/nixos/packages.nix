{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    chromium
    telegram-desktop
    kitty
    obsidian
    discord
    android-studio

    # CLI utils
    vim
    fastfetch
    file
    tree
    wget
    git
    gitui
    htop
    nix-index
    unzip
    zip
    ntfs3g
    brightnessctl
    swww
    bluez
    bluez-tools
    killall
    libnotify
    ripgrep
    pamixer

    # Coding stuff
    clang

    # GUI utils
    feh
    imv
    pavucontrol

    # Wayland stuff
    wl-clipboard

    # WMs and stuff
    ags
    anyrun

    # Screenshotting
    grim
    grimblast
    slurp

    # Other
    home-manager
  ];

  fonts.packages = with pkgs; [
    roboto
    kode-mono
    comfortaa
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
