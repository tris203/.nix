{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lookatmego = {
      url = "github:tris203/lookatmego";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });


      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        (import ./overlays/awesome-git.nix)
      ];
      substituters = [
        "https://cosmic.cachix.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    in
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/vm/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nix.settings = {
              substituters = substituters;
              trusted-public-keys = trusted-public-keys;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hmbkp";
            home-manager.users.tris = import ./home.nix;
          }
        ];
      };

      nixosConfigurations.x1 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/x1/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nix.settings = {
              substituters = substituters;
              trusted-public-keys = trusted-public-keys;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hmbkp";
            home-manager.users.tris = import ./home.nix;
          }
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wsl/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            nix.settings = {
              substituters = substituters;
              trusted-public-keys = trusted-public-keys;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tris = import ./home.nix;
          }
          inputs.nixos-wsl.nixosModules.wsl
        ];
      };

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ nixd nixpkgs-fmt deadnix ];
          };
        });

    };
}
