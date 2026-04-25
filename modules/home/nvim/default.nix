{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    sideloadInitLua = true;
  };

  xdg.configFile."nvim" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/nvim";
    recursive = true;
  };
}
