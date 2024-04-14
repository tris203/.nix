{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
url = "github:nix-community/NixOS-WSL";
inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/vm/configuration.nix
        ./modules/nixos/awesome.nix
        ./modules/nixos/discord.nix
        ./modules/nixos/general.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
         inputs.home-manager.nixosModules.home-manager
         {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.tris = import ./home.nix;
         }
      ];
    };

    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/wsl/configuration.nix
        ./modules/nixos/awesome.nix
        ./modules/nixos/discord.nix
        ./modules/nixos/general.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
        inputs.home-manager.nixosModules.defaults
	inputs.nixos-wsl.nixosModules.wsl
      ];
    };

  };
}
