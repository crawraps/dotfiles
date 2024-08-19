{ config, pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    initLua = ./init.lua;

    settings = {
      manager = {
        ratio = [1 3 4];
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
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

      manager.prepend_keymap = [
        { on = [ "l" ]; run = "plugin --sync smart-enter"; }
        { on = [ "<CR>" ]; run = "plugin --sync smart-enter"; }

        { on = [ "y" "y" ]; run = ["plugin yank-image" "yank"]; desc = "copy"; }
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
        { on = [ "p" "f" ]; run = ["plugin paste-file --args='quiet'"]; desc = "create new file from clipboard"; }

        { on = [ "g" "d" ]; run = ["cd ~/downloads"]; desc = "go downloads"; }
        { on = [ "g" "w" ]; run = ["cd $WALLPAPERS"]; desc = "go wallpapers"; }
        { on = [ "g" "c" ]; run = ["cd ~/.nix"]; desc = "go config"; }

        { on = [ "e" "p" ]; run = ["shell 'paper -f $0' --confirm"]; desc = "set as wallpaper"; }
      ];
    };

    flavors = {
      catppuccin = ./flavor.yazi;
    };

    theme = {
      flavor = {
        use = "catppuccin";
      };

      manager = {
        cwd = { fg = "white"; };
        border_symbol = " ";
        preview_hovered = { reversed = true; };
        tab_width = 14;

        find_keyword = { fg = "blue"; bg = "black"; reversed = true; };
        find_position = { fg = "lightblue"; bg = "black"; bold = true; };
      };

      status = {
        separator_open  = "";
        separator_close = "";
        separator_style = { fg = "blue"; bg = "blue"; };

        mode_normal = { fg = "white"; bg = "lightblue"; bold = true; };
        mode_select = { fg = "black"; bg = "#a6d189"; bold = true; };
        mode_unset  = { fg = "black"; bg = "#eebebe"; bold = true; };

        progress_label  = { fg = "white"; bold = true; };
        progress_normal = { fg = "lightblue"; bg = "blue"; };
        progress_error  = { fg = "#e78284"; bg = "blue"; };
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
          { name = "node_modules"; text = ""; }
          { name = "music"; text = "󱍙"; }
        ];

        prepend_conds = [
          { "if" = "dir & link"; text = "󰉒"; }
        ];
      };
    };

    plugins = {
      smart-enter = ./plugins/smart-enter;
      yank-image = ./plugins/yank-image;
      paste-file = ./plugins/paste-file;
    };
  };
}
