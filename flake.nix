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

    lookatmego = {
      url = "github:tris203/lookatmego";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = { nixpkgs, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      commonConfig = import ./hosts/common.nix;

      overlays = import ./overlays { inherit inputs; };
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            overlays.additions
            overlays.modifications
          ];
        }
      );
      mkHost = { host, extraModules ? [ ] }:
        nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            commonConfig
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            ./hosts/${host}/configuration.nix
          ] ++ extraModules;
        };
    in
    rec {
      inherit legacyPackages;

      nixosConfigurations = {
        x1 = mkHost { host = "x1"; };

        wsl = mkHost {
          host = "wsl";
          extraModules = [ inputs.nixos-wsl.nixosModules.wsl ];
        };
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
