{ pkgs, config, ... }:
{
home.file."${config.xdg.configHome}/rofi/config.rasi".source = ./tokyonight.rasi;
programs.rofi = {
  enable = true;
  # import the theme from the tokyonight.rasi file in the same directory
  };
}
