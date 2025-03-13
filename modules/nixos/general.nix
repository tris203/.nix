{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.lookatmego.packages.x86_64-linux.lookatmego
    inputs.zen-browser.packages.x86_64-linux.default # beta
    nautilus
    element-desktop
    gnome-screenshot
    calibre
    obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];
}
