{
  description = "rzls flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      default = import ./derivation.nix {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      };
    };
  };
}
