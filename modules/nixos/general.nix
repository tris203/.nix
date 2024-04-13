{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  gnome.nautilus
  gnome.gnome-screenshot
    calibre
    obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];
}
