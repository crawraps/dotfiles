{ pkgs, inputs, system, preferences, lib, ... }:

let cfg = preferences.modules.screenshots; in
lib.mkIf cfg {
  home.packages = with pkgs; [
    grim
    slurp
    hyprpicker
    inputs.hyprquickshot.packages.${system}.default
  ];
}