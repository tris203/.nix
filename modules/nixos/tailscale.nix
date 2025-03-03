{ config, pkgs, ... }: {

  services.tailscale.enable = true;

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  environment.systemPackages = with pkgs; [ tailscale ];
}
