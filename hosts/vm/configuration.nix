# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    ../common.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../theme.nix

    # ./modules/nixos/awesome.nix
    ../../modules/nixos/gnome.nix
    # ./modules/nixos/hyprland.nix
    ../../modules/nixos/cosmic.nix
    ../../modules/nixos/discord.nix
    ../../modules/nixos/general.nix
    ../../modules/nixos/programming_langs.nix
    ../../modules/nixos/terminal_tools.nix
  ];

  # Use thfigcne systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 7;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.tris.shell = pkgs.zsh;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Guernsey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "gb";
    xkb.variant = "";
  };

  services.gvfs.enable = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # services.picom.enable = true;
  programs.dconf.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tris = {
    isNormalUser = true;
    description = "Tris";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        firefox
        #  thunderbird
      ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?S
}
