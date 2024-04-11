{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/vm/configuration.nix
	./modules/nixos/awesome.nix
	./modules/nixos/zsh.nix
	./modules/nixos/discord.nix
	./modules/nixos/neovim.nix
        # inputs.home-manager.nixosModules.default
      ];
    };
  };
}
