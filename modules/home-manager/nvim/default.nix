{ config, pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
  inputs.neovim-nightly-overlay.overlay
];


  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
