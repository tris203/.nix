{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (import ../../overlays/awesome-git.nix)
  ];

  # Enable the X11 windowing system.


  services.displayManager = {
    sddm.enable = true;
    defaultSession = "none+awesome";
  };

  services.xserver = {
    enable = true;


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
