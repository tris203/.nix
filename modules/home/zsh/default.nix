{ pkgs, lib, config, ... }:
let
  tmuxsessionizer = pkgs.writeShellScriptBin "tmuxsessionizer" ./bin/tmux-sessionizer;
in
{

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;


    plugins = [
      pkgs.tmuxPlugins.prefix-highlight
      # Plugins go here
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-*:Tc"
      set-option -g default-terminal "tmux-256color"

      set -g mode-style "fg=#7aa2f7,bg=#3b4261"

      set -g message-style "fg=#7aa2f7,bg=#3b4261"
      set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

      set -g pane-border-style "fg=#3b4261"
      set -g pane-active-border-style "fg=#bb9af7"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=#7aa2f7,bg=#16161e"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=#15161e,bg=#{?#{client_prefix},#bb9af7,#7aa2f7},bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics] "
      set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M"

      setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#bb9af7"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
      setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#bb9af7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

      # tmux-plugins/tmux-prefix-highlight support
      set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
      set -g @prefix_highlight_output_suffix ""

      bind -r f run-shell "tmux neww tmuxsessionizer"

      set -g set-clipboard on
      set -g detach-on-destroy off

      bind -r ^ last-window
      bind -r k select-pane -U 
      bind -r j select-pane -D
      bind -r h select-pane -L 
      bind -r l select-pane -R
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      "ll" = "ls -alh";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gh"
        "tmux"
        "sudo"
        "colorize"
        "colored-man-pages"
      ];
      extraConfig = ''
        ZSH_TMUX_AUTOSTART=true
        ZSH_TMUX_DEFAULT_SESSION_NAME=main
      '';
    };
  };

  home.packages = [ tmuxsessionizer ];

  # sym link .config/tmux/tmux.conf to ¬/.tmux.conf
  # home.file.".tmux.conf".source =
    # config.lib.file.mkOutOfStoreSymlink "/home/tris/.config/tmux/tmux.conf";
}
