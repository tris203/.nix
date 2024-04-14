{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (import ../../overlays/awesome-git.nix)
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      package = pkgs.awesome-luajit-git;
      enable = true;
      luaModules = with pkgs.luajitPackages; [
        luarocks
        luadbi-mysql
        lgi
      ];
    };
  };
}
