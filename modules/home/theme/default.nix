{ pkgs, ... }: {

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  fonts.fontconfig.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix.polarity = "dark";

  stylix.targets.neovim.enable = false;
  stylix.image = ./wallpaper.jpg;

  stylix.opacity = {
    desktop = 0.5;
    terminal = 0.8;
  };

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "FreeSans";
    };

    serif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "FreeSerif";
    };

    sizes = {
      applications = 10;
    };
  };


  # home.pointerCursor = {
  #   gtk.enable = true;
  #   # x11.enable = true;
  #   package = pkgs.bibata-yycursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  # };

  # gtk = {
  #   enable = true;
  #
  #   theme = {
  #     package = pkgs.tokyonight-gtk-theme;
  #     name = "Tokyonight-Dark";
  #   };
  #
  #   iconTheme = {
  #     package = pkgs.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  #
  #   font = {
  #     name = "Sans";
  #     size = 11;
  #   };
  # };

}
