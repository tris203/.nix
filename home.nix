{ ... }:

{
  imports = [

    ./modules/home/general
    ./modules/home/ghostty
    ./modules/home/git
    ./modules/home/nvim
    ./modules/home/zsh
    ./modules/home/rofi
    ./modules/home/theme
    ./modules/home/chrome
  ];

  home.username = "tris";
  home.homeDirectory = "/home/tris";

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
