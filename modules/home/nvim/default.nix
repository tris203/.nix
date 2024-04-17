{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
# TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/dotfiles/nvim";
    recursive = true;
    };
}
