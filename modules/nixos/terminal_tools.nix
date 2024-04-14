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
    tmux
    ripgrep
    fzf
    neofetch
    docker
    xclip
  ];


}
