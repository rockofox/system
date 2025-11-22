{ config, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = with config.colorScheme.palette; ''
      set-option -g status-style "fg=#${base04},bg=#${base01}"
      set-window-option -g window-status-style "fg=#${base04},bg=default"
      set-window-option -g window-status-current-style "fg=#${base0A},bg=default"
      set-option -g pane-border-style "fg=#${base01}"
      set-option -g pane-active-border-style "fg=#${base02}"
      set-option -g message-style "fg=#${base05},bg=#${base01}"
      set-option -g display-panes-active-colour "#${base0B}"
      set-option -g display-panes-colour "#${base0A}"
      set-window-option -g clock-mode-colour "#${base0B}"
      set-window-option -g mode-style "fg=#${base04},bg=#${base02}"
      set-window-option -g window-status-bell-style "fg=#${base01},bg=#${base08}"
      set-option -g mouse on
      bind -T root C-] select-pane -t :.+

      unbind C-b
      set -g prefix `
      bind-key ` send-prefix

      set -g default-terminal "screen-256color"
    '';
  };
}
