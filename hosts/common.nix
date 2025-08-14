{ inputs, ... }:
let
  overlays = [
    # inputs.neovim-nightly-overlay.overlays.default
    (import ../overlays/awesome-git.nix)
  ];
  substituters = [
    "https://cosmic.cachix.org/"
    "https://nix-community.cachix.org"
    "https://hyprland.cachix.org"
  ];
  trusted-public-keys = [
    "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

in
{
  nixpkgs.overlays = overlays;
  nix.settings = {
    substituters = substituters;
    trusted-public-keys = trusted-public-keys;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbkp";
  home-manager.users.tris = import ../home.nix;

}
