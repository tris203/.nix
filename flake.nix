{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nixos-cosmic = { url = "github:lilyinstarlight/nixos-cosmic"; };

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/vm/configuration.nix
        # ./modules/nixos/awesome.nix
        ./modules/nixos/gnome.nix
        # ./modules/nixos/hyprland.nix
        ./modules/nixos/cosmic.nix
        ./modules/nixos/discord.nix
        ./modules/nixos/general.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
        inputs.home-manager.nixosModules.home-manager
        {
          nix.settings = {
            substituters = [
              "https://cosmic.cachix.org/"
              "https://ghostty.cachix.org"
            ];
            trusted-public-keys = [
              "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
            ];
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hmbkp";
          home-manager.users.tris = import ./home.nix;
        }
        inputs.nixos-cosmic.nixosModules.default
      ];
    };

    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/wsl/configuration.nix
        ./modules/nixos/general.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tris = import ./home.nix;
        }
        inputs.nixos-wsl.nixosModules.wsl
      ];
    };

  };
}
