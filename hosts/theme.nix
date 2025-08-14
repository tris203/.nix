{ pkgs, ... }:
{
  stylix = {
    enable = true;
    opacity = {
      desktop = 0.5;
      terminal = 0.8;
    };
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
}
