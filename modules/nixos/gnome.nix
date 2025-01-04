{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # gnomeExtensions.pop-launcher-super-key
    # pop-launcher
    gnomeExtensions.pop-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.improved-workspace-indicator
    gnome-tweaks
  ];

}
