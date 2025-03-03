{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;

  services.displayManager.sddm.enable = true;

  services.xserver = { enable = true; };

  environment.sessionVariables = { WLR_RENDERER_ALLOW_SOFTWARE = "1"; };

  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    swww
    rofi-wayland
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

}
