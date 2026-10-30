{ inputs, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # Match nixpkgs' cached Hyprland build and provide a managed session.
    withUWSM = true;
  };

  hardware.graphics.enable = true;

  hardware.nvidia.modesetting.enable = true;

  services.blueman.enable = true;

  # Provide encrypted Secret Service storage, unlocked by the login PAM stack.
  services.gnome.gnome-keyring.enable = true;

  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  environment.sessionVariables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    waybar
    libnotify
    awww
    rofi
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
