{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    gcc
    zig
    clang
    wget
    curl
    jq
    ripgrep
    fzf
    neofetch
    docker
    xclip
    tree
  ];


}
