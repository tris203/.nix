{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (import ../../overlays/awesome-git.nix)
  ];

  # Enable the X11 windowing system.


  services.displayManager = {
    defaultSession = "none+awesome";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters = {
        gtk = {
          enable = true;
          theme = {
            name = "Tokyonight-Dark-BL";
            package = pkgs.tokyo-night-gtk;
          };
        };
      };
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
