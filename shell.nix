let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nixd
    nixpkgs-fmt
  ];

  LD_LIBRARY_PATH = "${pkgs.wayland}/lib";
}
