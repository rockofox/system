{ pkgs, lib, nix-colors, ... }:
let
    vars = import ../vars.nix;
in
rec {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
      nerdfonts
      julia-mono
      lato
      jetbrains-mono
  ];

  manual.manpages.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.home-manager.manual.manpages.enable = false;
  colorScheme = nix-colors.colorSchemes.default-dark;

  programs.kitty.enable = true;
  programs.kitty.darwinLaunchOptions = [
    "--single-instance"
    "--directory=~"
  ];
  programs.kitty.font.name = "CaskaydiaCove Nerd Font";
  programs.kitty.font.size = 15;
  programs.kitty.settings = {
    # background_opacity = "0.85";
    copy_on_select = true;
    cursor_blink_interval = 0;
    editor = "vim";
    hide_window_decorations = true;
    scrollback_pager_history_size = 1;
    update_check_interval = 0;
    foreground = "#${colorScheme.colors.base05}";
    background = "#${colorScheme.colors.base00}";
  };
  programs.kitty.extraConfig = "
  term xterm-256color
  window_padding_width 4
  tab_bar_style powerline
  tab_powerline_style slanted
  kitty_mod cmd
  map kitty_mod+t     new_tab_with_cwd
  map kitty_mod+enter new_window_with_cwd
  confirm_os_window_close 0
  enable_audio_bell no
  macos_option_as_alt yes
  ";
  programs.discocss = {
    enable = true;
    discordAlias = false;
    css = ''
      .theme-light {
        --background-primary: #f3f4f644;
        --background-primary-alt: #eeeff244;
        --background-secondary: #e5e7eb44;
        --background-secondary-alt: #d1d5db44;
        --background-tertiary: #dfe2e744;
      }
      .theme-dark {
        --background-primary: #${colorScheme.colors.base00};
        --background-secondary: #${colorScheme.colors.base01};
        /* --background-primary-alt: #eeeff244;
        --background-secondary-alt: #d1d5db44;
        --background-tertiary: #dfe2e744; */
        }
    '';
    };

  imports = [
    ./autoraise.nix
    ./git.nix
    ./neovim
    ./yabai.nix
    ./zsh
    nix-colors.homeManagerModule
  ];
}
