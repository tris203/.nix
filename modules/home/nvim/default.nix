{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/nvim";
    recursive = true;
  };
}
