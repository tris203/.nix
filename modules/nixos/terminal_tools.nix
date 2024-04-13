{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  cargo
  gcc
  zig
  clang
    wget
    curl
    jq
    alacritty
    tmux
    ripgrep
    fzf
    neofetch
    docker
    xclip
  ];

   fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];

}
