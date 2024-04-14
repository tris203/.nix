{ pkgs, config, ... } :
{

   home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];

fonts.fontconfig.enable = true;

gtk = {
    enable = true;
    theme = {
    name = "Tokyonight-Dark-BL";
    package = pkgs.tokyo-night-gtk;
    };
    iconTheme = {
    name = "Flat-Remix-Teal-Dark";
    package = pkgs.flat-remix-icon-theme;
    };
    gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
    };
};

dconf.settings = {
    "org/gnome/desktop/interface" = {
        name = "Tokyonight-Dark-BL";
    };
};

xdg.configFile = {
  "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
};



}
