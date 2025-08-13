{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = false;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
}
