{ inputs, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;

  services.blueman.enable = true;

  services.xserver = {
    enable = true;
    displayManager = { gdm = { enable = true; wayland = true; }; };
  };

  environment.sessionVariables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    waybar
    libnotify
    swww
    rofi-wayland
    brightnessctl
    cliphist
    hyprshot
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

}
