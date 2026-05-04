{ pkgs, preferences, lib, ... }:

let
  cfg = preferences.modules.file-manager;
  inherit (preferences.modules.terminal) foot;
  terminal-cmd = if foot then "footclient" else "kitty -1";

  fetchYaziPlugin = { repo, sha256, owner ? "crawraps", rev ? "main" }:
    pkgs.fetchFromGitHub {
      inherit owner repo rev sha256;
    };

  catppuccin-yazi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "fc69d6472d29b823c4980d23186c9c120a0ad32c";
    sha256 = "0g165gwajnxigalni8ngd6jb0kfpirqdy1xix2k3i9dxchhgf39s";
  };

  catppuccin-flavor = pkgs.runCommandLocal "catppuccin-mocha-teal-flavor" { } ''
    mkdir -p $out
    cp ${catppuccin-yazi}/themes/mocha/catppuccin-mocha-teal.toml $out/flavor.toml
  '';
in
lib.mkIf cfg {
  home.packages = with pkgs; [
    gtrash # Trash analyzer
    ncdu # Disk usage analyzer
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    initLua = ./assets/init.lua;

    settings = {
      mgr = {
        ratio = [1 3 4];
        linemode = "size";
        show_hidden = true;
        show_symlink = false;
      };

      input = {
        cd_origin = "bottom-center";
        cd_offset = [0 0 48 3];
        find_origin = "bottom-center";
        find_offset = [0 0 48 3];
        create_origin = "bottom-center";
        create_offset = [0 0 48 3];
        delete_origin = "bottom-center";
        delete_offset = [0 0 48 3];
        search_origin = "bottom-center";
        search_offset = [0 0 48 3];
        shell_origin = "bottom-center";
        shell_offset = [0 0 48 3];
      };
    };

    keymap = {
      input.prepend_keymap = [
        { on = [ "<Esc>" ]; run = "close"; }
      ];

      mgr.prepend_keymap = [
        { on = [ "l" ]; run = "plugin smart-enter"; }
        { on = [ "<CR>" ]; run = "plugin smart-enter"; }

        { on = [ "y" "y" ]; run = ["yank"]; desc = "copy"; }
        { on = [ "y" "c" ]; run = ["plugin yank-file"]; desc = "copy file content"; }
        { on = [ "y" "p" ]; run = ["copy path"]; desc = "copy path"; }
        { on = [ "y" "n" ]; run = ["copy filename"]; desc = "copy name"; }

        { on = [ "d" "d" ]; run = ["yank --cut"]; desc = "cut"; }
        { on = [ "d" "r" ]; run = ["remove --force"]; desc = "remove"; }
        { on = [ "d" "R" ]; run = ["remove --permanently"]; desc = "remove permanently"; }

        { on = [ "<C-n>" ]; run = ["tab_create --current"]; desc = "new tab"; }
        { on = [ "<C-w>" ]; run = ["close"]; desc = "close tab"; }
        { on = [ "<A-l>" ]; run = ["tab_switch --relative 1"]; desc = "next tab"; }
        { on = [ "<A-h>" ]; run = ["tab_switch --relative -1"]; desc = "prev tab"; }
        { on = [ "<C-l>" ]; run = ["tab_swap 1"]; desc = "move tab forward"; }
        { on = [ "<C-h>" ]; run = ["tab_swap -1"]; desc = "move tab backward"; }

        { on = [ "p" "p" ]; run = ["paste"]; desc = "paste"; }
        { on = [ "p" "o" ]; run = ["paste --force"]; desc = "paste and overwrite"; }
        { on = [ "p" "f" ]; run = ["plugin paste-file -- --quiet"]; desc = "create new file from clipboard"; }

        { on = [ "g" "d" ]; run = ["cd ~/downloads"]; desc = "go downloads"; }
        { on = [ "g" "w" ]; run = ["cd $WALLPAPERS"]; desc = "go wallpapers"; }
        { on = [ "g" "c" ]; run = ["cd ~/.nix"]; desc = "go config"; }

        { on = [ "e" "p" ]; run = ["shell 'paper -f \$0' --confirm"]; desc = "set as wallpaper"; }
      ];
    };

    flavors = {
      catppuccin = catppuccin-flavor;
    };

    theme = {
      flavor = {
        use = "catppuccin";
      };

      mgr = {
        cwd = { fg = "white"; };
        border_symbol = " ";
        preview_hovered = { reversed = true; };
        tab_width = 14;

        find_keyword = { fg = "blue"; bg = "black"; reversed = true; bold = true; };
        find_position = { fg = "lightblue"; bg = "black"; bold = true; };
      };

      indicator = {
        padding = { open = " "; close = " "; };
      };

      tabs = {
        active = { fg = "lightblue"; bg = "reset"; bold = true; };
        inactive = { fg = "white"; bg = "reset"; };
        sep_outer = { open = " ["; close = "] "; };
        sep_inner = { open = ""; close = ""; };
      };

      status = {
        overall = { fg = "white"; bg = "reset"; };
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };

        progress_label  = { fg = "white"; bold = true; };
        progress_normal = { fg = "lightblue"; bg = "blue"; };
        progress_error  = { fg = "#e78284"; bg = "blue"; };
      };

      mode = {
        normal_main = { fg = "white"; bg = "lightblue"; bold = true; };
        select_main = { fg = "black"; bg = "#a6d189"; bold = true; };
        unset_main = { fg = "black"; bg = "#eebebe"; bold = true; };
      };

      select = {
        border = { fg = "blue"; };
      };

      input = {
        border = { fg = "blue"; };
        value = { fg = "white"; };
      };

      completion = {
        border = { fg = "blue"; };
      };

      tasks = {
        border = { fg = "blue"; };
      };

      which = {
        mask = { bg = "black"; };
        cand = { fg = "lightblue"; };
        desc = { fg = "blue"; };
        separator_style = { fg = "blue"; };
        separator = " -> ";
      };

      help = {
        on = { fg = "lightblue"; };
        run = { fg = "lightblue"; };
        desc = { fg = "white"; };
        hovered = { reversed = true; bold = true; };
        footer  = { fg = "white"; bg = "blue"; };
      };

      notify = {
        title_info = { fg = "lightblue"; };
      };

      filetype = {
        rules = [
          { mime = "image/*"; fg = "#81c8be"; }
          { mime = "{audio,video}/*"; fg = "#e5c890"; }
          { mime = "application/*zip"; fg = "#f4b8e4"; }
          { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#f4b8e4"; }
          { mime = "application/{pdf,doc,rtf,md,vnd.*}"; fg = "#a6d189"; }

          { name = "*"; is = "exec"; fg = "#e78284"; }

          { name = "*"; fg = "white"; }
          { name = "*/"; fg = "lightblue"; }
        ];
      };

      icon = {
        prepend_dirs = [
          { name = "downloads"; text = "󰉍"; }
          { name = "images"; text = "󰉏"; }
          { name = "documents"; text = "󰲂"; }
          { name = "node_modules"; text = ""; }
          { name = "music"; text = "󱍙"; }
        ];

        prepend_conds = [
          { "if" = "dir"; text = "󰉋"; }
          { "if" = "dir & link"; text = "󰉒"; }
        ];
      };
    };

    plugins = {
      smart-enter = fetchYaziPlugin { repo = "smart-enter.yazi"; sha256 = "1lmslx93yn8k9cr4iapl5w7rfqc54s378x1ij2bdyi5zds6p9c23"; };
      yank-file = fetchYaziPlugin { repo = "yank-file.yazi"; sha256 = "0s4r8xzn7jhi7acc3vrp1idsf5j53rm4yqw2vj45waj1icasay7p"; };
      paste-file = fetchYaziPlugin { repo = "paste-file.yazi"; sha256 = "149kdl4z3ixp84xd9fz7yry0ai2lxp5sj6231clqkl51s4s32nvm"; };
      hide-tab-bar = fetchYaziPlugin { repo = "hide-tab-bar.yazi"; sha256 = "sha256-ESLyJ3j9voLJOBwxrzEGdbV1tCRqjK/08X+YmQfFCys="; };
    };
  };

  xdg.desktopEntries = {
    yazi = {
      name = "Yazi";
      exec = "${terminal-cmd} yazi";
      terminal = false;
      icon = ./assets/pictures/yazi.svg;
      categories = [ "Utility" "FileManager" ];
      comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
      type = "Application";
      mimeType = [ "inode/directory" ];
    };
  };
}
