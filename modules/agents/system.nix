{ pkgs, lib, preferences, ... }:
let cfg = preferences.modules.agents; in
lib.mkIf cfg.ollama {
  services.ollama = {
    enable = true;
    user = "ollama";
    environmentVariables = { OLLAMA_FLASH_ATTENTION = "1"; };
  };
}