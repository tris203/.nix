{ config, ... }:
{
  home.file."${config.xdg.configHome}/rofi/config.rasi".source = ./tokyonight.rasi;
  programs.rofi = {
    enable = true;
  };
}
