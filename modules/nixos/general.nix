{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.lookatmego.packages.x86_64-linux.lookatmego
    nautilus
    gnome-screenshot
    calibre
    obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];
}
