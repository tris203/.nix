{ pkgs, ... }: {
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
    fastfetch
    docker
    xclip
    wl-clipboard
    tree
    htop
  ];

}
