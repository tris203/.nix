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

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/vm/configuration.nix
        ./modules/nixos/awesome.nix
        ./modules/nixos/discord.nix
        ./modules/nixos/general.nix
        ./modules/nixos/git.nix
        ./modules/nixos/neovim.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
        ./modules/nixos/zsh.nix
         inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/wsl/configuration.nix
        ./modules/nixos/awesome.nix
        ./modules/nixos/discord.nix
        ./modules/nixos/general.nix
        ./modules/nixos/git.nix
        ./modules/nixos/neovim.nix
        ./modules/nixos/programming_langs.nix
        ./modules/nixos/terminal_tools.nix
        ./modules/nixos/zsh.nix
         inputs.home-manager.nixosModules.default
	 inputs.nixos-wsl.nixosModules.wsl
      ];
    };

  };
}
