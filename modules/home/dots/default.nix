{ config, ... }:
{
  xdg.configFile."hypr" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/hypr";
    recursive = true;
  };

  xdg.configFile."waybar" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/waybar";
    recursive = true;
  };

  xdg.configFile."dunst" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/dunst";
    recursive = true;
  };
}
