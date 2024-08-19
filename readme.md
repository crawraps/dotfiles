My [NixOS](https://nixos.org) + [Hyprland](https://github.com/hyprwm/Hyprland) linux configuration.

# Repo structure
## archive
This directory contains my old configuration of Hyprland and based on ArchLinux. These files are outdated and will not be supported in the future.

## nix-flake
This is [nix flake](https://nixos.wiki/wiki/Flakes) with my current configuration. System-wide configs and per-user configs are located in nix-flake/nixos folder and in nix-flake/home-manager folder correspondingly. All following description is related only to this configuration.

## wallpapers
Just some of my wallpapers

# Theming
Generating new colorschemes is handled by wallust. You can find templates for different applications in `home-manager/config/wallust/templates`. Each of these applications imports generated files from a specific location
All my themes is generated automatically from images (matching current wallpaper). Wallpaper management is served by simple bash script I wrote called `paper`.  Some of the apps needs to be applied with new colors and `paper` do this job. Take a look at `home-manager/executables/scripts` and change it by your preference

# Configured applications
## Widgets
Desktop widgets are rendered by [ags](https://github.com/Aylur/ags). Following widgets are available:
- top-bar - dynamic bar that changes its layout based on amount of windows on workspace
- sliders - sound and brightness sliders on the right side of the screen
- notifications - widgets showing new notifications
Each widget can be disabled and hidden separately in `ags/scripts/index.ts`. Themed colors are stored in `.config/colors/ags.scss` file and generated by wallust.
## D-menu
As d-menu alternative I use [anyrun](https://github.com/anyrun-org/anyrun). Anyrun is more like spotlight for macos because it can be used as calculator, translator and application launcher in one input line.
Anyway I would like to create my own implementation using ags.
## Firefox
My userChrome config is based on [ShyFox](https://github.com/Naezr/ShyFox). Please refer to it for initial configuration. Themed colors are generated in {firefox_profile}/chrome/colors.css dynamically by wallust. Unfortunately, there is no way to update userChrome.css without restarting firefox or without using custom userconfig (custom scripts). I don't want to include custom scripts in my setup, but if you wish to I can suggest use [fx-autoconfig](https://github.com/MrOtherGuy/fx-autoconfig) or [see others](https://www.userchrome.org/what-is-userchrome-js.html)

## [Obsidian](https://obsidian.md/)
Notes application. Obsidian can be configured with css and each obsidian vault contains separated css styles. Base theme I use is [obsidian-minimal](https://github.com/kepano/obsidian-minimal). On top of that I use custom css snippet generated by wallust

## Others
- [kitty](https://github.com/kovidgoyal/kitty) - terminal emulator. It uses custom colors `.config/kitty/colors.conf` generated by wallust
- [yazi](https://github.com/sxyazi/yazi) - extremely fast file manager written on Rust
- [wallust](https://codeberg.org/explosion-mental/wallust) - pywal alternative written on Rust
- [swww](https://github.com/LGFae/swww) - wallpaper daemon
- [neovim](https://github.com/neovim/neovim) - text editor. Themed colors are generated in `nvim/lua/crawraps/plugins/colorscheme.lua` by wallust.
