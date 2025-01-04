{ pkgs, config, ... }: {

  home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  fonts.fontconfig.enable = true;

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Tokyonight-Dark-BL";
  #     package = pkgs.tokyo-night-gtk;
  #   };
  #   iconTheme = {
  #     name = "Flat-Remix-Teal-Dark";
  #     package = pkgs.flat-remix-icon-theme;
  #   };
  #   gtk3 = {
  #     extraConfig.gtk-application-prefer-dark-theme = true;
  #   };
  # };
  #
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     name = "Tokyonight-Dark-BL";
  #   };
  #
  #   # disable incompatible shortcuts
  #   "org/gnome/mutter/wayland/keybindings" = {
  #     # restore the keyboard shortcuts: disable <super>escape
  #     restore-shortcuts = [ ];
  #   };
  #   "org/gnome/desktop/wm/keybindings" = {
  #     # hide window: disable <super>h
  #     minimize = [ "<super>comma" ];
  #     # switch to workspace left: disable <super>left
  #     switch-to-workspace-left = [ ];
  #     # switch to workspace right: disable <super>right
  #     switch-to-workspace-right = [ ];
  #     # maximize window: disable <super>up
  #     maximize = [ ];
  #     # restore window: disable <super>down
  #     unmaximize = [ ];
  #     # move to monitor up: disable <super><shift>up
  #     move-to-monitor-up = [ ];
  #     # move to monitor down: disable <super><shift>down
  #     move-to-monitor-down = [ ];
  #     # super + direction keys, move window left and right monitors, or up and down workspaces
  #     # move window one monitor to the left
  #     move-to-monitor-left = [ ];
  #     # move window one workspace down
  #     move-to-workspace-down = [ ];
  #     # move window one workspace up
  #     move-to-workspace-up = [ ];
  #     # move window one monitor to the right
  #     move-to-monitor-right = [ ];
  #     # super + ctrl + direction keys, change workspaces, move focus between monitors
  #     # move to workspace below
  #     switch-to-workspace-down = [ "<primary><super>down" "<primary><super>j" ];
  #     # move to workspace above
  #     switch-to-workspace-up = [ "<primary><super>up" "<primary><super>k" ];
  #     # toggle maximization state
  #     toggle-maximized = [ "<super>m" ];
  #     # close window
  #     close = [ "<super>q" "<alt>f4" ];
  #   };
  #   "org/gnome/shell/keybindings" = {
  #     open-application-menu = [ ];
  #     # toggle message tray: disable <super>m
  #     toggle-message-tray = [ "<super>v" ];
  #     # show the activities overview: disable <super>s
  #     toggle-overview = [ ];
  #   };
  #   "org/gnome/mutter/keybindings" = {
  #     # disable tiling to left / right of screen
  #     toggle-tiled-left = [ ];
  #     toggle-tiled-right = [ ];
  #   };
  #   "org/gnome/settings-daemon/plugins/media-keys" = {
  #     # lock screen
  #     screensaver = [ "<super>escape" ];
  #     # home folder
  #     home = [ "<super>f" ];
  #     # launch email client
  #     email = [ "<super>e" ];
  #     # launch web browser
  #     www = [ "<super>b" ];
  #     # launch terminal
  #     terminal = [ "<super>t" ];
  #     # rotate video lock
  #     rotate-video-lock-static = [ ];
  #   };
  #   "org/gnome/mutter" = {
  #     workspaces-only-on-primary = false;
  #   };
  # };
  #
  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };
  #
}
