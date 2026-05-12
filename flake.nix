{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprquickshot = {
      url = "github:jamdon2/hyprquickshot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    calc = {
      url = "github:crawraps/calc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    preferences = {
      user = {
        name = "careem";
        email = "careem@crawraps.com";
        extraGroups = [ "networkmanager" "wheel" "input" "docker" "dialout" "adbusers" ];
      };

      system = {
        hostname = "nixos";
        timezone = "Asia/Tbilisi";
        locale = "en_US.UTF-8";
        stateVersion = "24.05";
      };

      modules = {
        browser = {
          firefox = false;
          zen = true;
          chromium = true;
        };
        terminal = {
          foot = true;
          kitty = false;
        };
        compositor = {
          hyprland = true;
          niri = false;
        };
        widgets = {
          qs = true;
          ags = false;
          sherlock = false;
        };
        agents = {
          claude = false;
          gemini = false;
          opencode = true;
          ollama = true;
        };
        appearance = true;
        bluetooth = { tui = true; };
        development = true;
        direnv = true;
        email = true;
        git = { tui = true; };
        system-maintenance = {
          tui = true;
          auto-update = true;
          collect-garbage = true;
        };
        media = {
          sound = { players = false; };
          video = {
            players = true;
            recording = true;
          };
        };
        text-editor = { neovim = true; };
        productivity = true;
        screenshots = true;
        utilities = true;
        file-manager = true;
        auth = true;
        bootloader = true;
        docker = false;
        env = { zsh = true; };
        security = true;
        kdeConnect = true;
        keyboard = true;
        ld = true;
        locale = true;
        mongodb = false;
        network = true;
        user = true;
      };
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit pkgs-stable inputs system self;
        preferences = preferences;
      };
      modules = [
        ./modules/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            overwriteBackup = true;
            extraSpecialArgs = { inherit pkgs-stable inputs system self; preferences = preferences; };
            users.${preferences.user.name} = import ./modules/home-bundle.nix;
          };
        }
      ];
    };
  };
}
