{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
