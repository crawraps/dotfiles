{ preferences, ... }: let inherit (preferences.modules.terminal) foot kitty; in {
  "$mod" = "SUPER";

  # apps
  "$term" = if foot then "footclient" else "kitty -1";
  "$launcher" = "toggle-launcher";

  # workspaces
  "$1" = "1";
  "$2" = "2";
  "$3" = "3";
  "$4" = "4";
  "$5" = "5";
  "$6" = "6";
  "$7" = "7";
  "$8" = "8";
  "$9" = "9";
  "$0" = "0";
}
