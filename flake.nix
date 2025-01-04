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

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "tris";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
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
          inputs.nixos-cosmic.nixosModules.default
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/wsl/configuration.nix
          ./modules/nixos/general.nix
          ./modules/nixos/programming_langs.nix
          ./modules/nixos/terminal_tools.nix
          inputs.nixos-wsl.nixosModules.wsl
        ];
      };

      homeConfigurations = {
        tris = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          # useGlobalPkgs = true;
          # useUserPackages = true;
          # backupFileExtension = "hmbkp";
          extraSpecialArgs = { inherit inputs system username; };
        };
      };

    };
}
