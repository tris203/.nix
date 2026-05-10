{ inputs, pkgs, ... }:
{
  imports = [
    ./theme.nix

    ../modules/nixos/general.nix
    ../modules/nixos/programming_langs.nix
    ../modules/nixos/terminal_tools.nix
  ];

  nix.settings = {
    substituters = [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbkp";
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.tris = import ../home.nix;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.tris.shell = pkgs.zsh;
  users.users.tris = {
    isNormalUser = true;
    description = "Tris";
  };
}
