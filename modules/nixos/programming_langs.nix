{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    rustc
    nodePackages_latest.nodejs
  ];
}
