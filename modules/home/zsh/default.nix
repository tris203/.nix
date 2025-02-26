{ pkgs, lib, config, ... }:
let
  tmuxsessionizer =
    pkgs.writeShellScriptBin "tmuxsessionizer" ./bin/tmux-sessionizer;
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
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.continuum
      # Plugins go here
    ];
    extraConfig = ''
      # Generals

      ## enable undercurl

      # https://github.com/AstroNvim/AstroNvim/issues/1336#issuecomment-1317609457

      set -g default-terminal "screen-256color"

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -g allow-passthrough on

      ## color correction

      # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour

      set -as terminal-features ",alacritty*:RGB"

      set -as terminal-overrides ",alacritty*:Tc"

      # set-option -g default-shell /bin/zsh
      set -g mouse on
      set -s escape-time 0

      set -g base-index 1              # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g set-clipboard on          # use system clipboard

      # set -g @plugin 'tmux-plugins/tpm'

      # set -g @plugin 'tmux-plugins/tmux-sensible'
      #set -g @plugin 'sainnhe/tmux-fzf'

      # '@pane-is-vim' is a pane-local option that is set by the plugin on load,
      # and unset when Neovim exits or suspends; note that this means you'll probably
      # not want to lazy-load smart-splits.nvim, as the variable won't be set until
      # the plugin is loaded

      # Smart pane switching with awareness of Neovim splits.
      bind-key -n M-h if -F "#{@pane-is-vim}" 'send-keys M-h'  'select-pane -L'
      bind-key -n M-j if -F "#{@pane-is-vim}" 'send-keys M-j'  'select-pane -D'
      bind-key -n M-k if -F "#{@pane-is-vim}" 'send-keys M-k'  'select-pane -U'
      bind-key -n M-l if -F "#{@pane-is-vim}" 'send-keys M-l'  'select-pane -R'

      # Smart pane resizing with awareness of Neovim splits.
      bind-key -n C-h if -F "#{@pane-is-vim}" 'send-keys C-h' 'resize-pane -L 3'
      bind-key -n C-j if -F "#{@pane-is-vim}" 'send-keys C-j' 'resize-pane -D 3'
      bind-key -n C-k if -F "#{@pane-is-vim}" 'send-keys C-k' 'resize-pane -U 3'
      bind-key -n C-l if -F "#{@pane-is-vim}" 'send-keys C-l' 'resize-pane -R 3'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if -F \"#{@pane-is-vim}\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if -F \"#{@pane-is-vim}\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l

      # set -g @plugin 'tmux-plugins/tmux-yank'
      # set -g @plugin 'tmux-plugins/tmux-resurrect'
      # set -g @plugin 'tmux-plugins/tmux-continuum'
      # set -g @plugin 'lewis6991/gh_notify.tmux'

      # set -g @plugin 'omerxx/tmux-sessionx'

      # set -g @resurrect-strategy-nvim 'session'

      # set -g @continuum-save-interval '10'

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # forget the find window.  That is for chumps
      bind -r f run-shell "tmux neww tmuxsessionizer"
      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      set -g status-right 'Continuum status: #{continuum_status}'

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
      set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #{gh_notifications}"

      setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#bb9af7"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
      setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#bb9af7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

      # tmux-plugins/tmux-prefix-highlight support
      set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
      set -g @prefix_highlight_output_suffix ""

      # run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };


  xdg.configFile."starship" = {
    # TODO: Make this path come from the flakes config
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/code/.nix/.dotfiles/starship";
    recursive = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = { "ll" = "ls -alh"; };
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    #   {
    #     name = "powerlevel10k-config";
    #     src = lib.cleanSource ./p10k-config;
    #     file = "p10k.zsh";
    #   }
    # ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "gh" "tmux" "sudo" "colorize" "colored-man-pages" "direnv" "fzf" "vi-mode" ];
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
