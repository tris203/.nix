{ pkgs, config, ... }: {

  home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  fonts.fontconfig.enable = true;

}
