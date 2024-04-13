{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    calibre
    obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];
}
