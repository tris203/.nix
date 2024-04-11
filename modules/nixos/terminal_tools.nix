{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    jq
    alacritty
    tmux
    ripgrep
    fzf
    neofetch
    docker
  ];
}
