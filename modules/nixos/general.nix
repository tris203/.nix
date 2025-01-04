{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
    gnome-screenshot
    calibre
    # obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];
}
