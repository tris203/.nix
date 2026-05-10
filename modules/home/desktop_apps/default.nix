{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    inputs.lookatmego.packages.${system}.lookatmego
    nautilus
    element-desktop
    gnome-screenshot
    calibre
    obsidian
    spotify
    orca-slicer
    vesktop
    (discord.override {
      withVencord = true;
      withOpenASAR = true;
    })
  ];
}
