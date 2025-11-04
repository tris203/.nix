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

    lookatmego = {
      url = "github:tris203/lookatmego";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    stylix = {
      url = "github:danth/stylix";
    };


  };

  outputs = { nixpkgs, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      commonConfig = import ./hosts/common.nix;

      overlays = import ./overlays { inherit inputs; };
    in
    rec {
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            overlays.additions
            overlays.modifications
            #overlays.unstable-packages
            # inputs.neovim-nightly-overlay.overlays.default
          ];
        }
      );

      nixosConfigurations = {
        # vm = nixpkgs.lib.nixosSystem {
        #   pkgs = legacyPackages.x86_64-linux;
        #   specialArgs = { inherit inputs; };
        #   modules = [
        #     commonConfig
        #     inputs.stylix.nixosModules.stylix
        #     inputs.home-manager.nixosModules.home-manager
        #     ./hosts/vm/configuration.nix
        #   ];
        # };

        x1 = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            commonConfig
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            ./hosts/x1/configuration.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [
            commonConfig
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-wsl.nixosModules.wsl
            ./hosts/wsl/configuration.nix
          ];
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
