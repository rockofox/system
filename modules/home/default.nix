{ pkgs, lib, ... }:
let
    vars = import ../vars.nix;
in
{
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

  programs.kitty.enable = true;
  programs.kitty.darwinLaunchOptions = [
    "--single-instance"
    "--directory=~"
  ];
  programs.kitty.font.name = "JetBrainsMono Nerd Font";
  programs.kitty.font.size = 15;
  programs.kitty.settings = {
    # background_opacity = "0.85";
    copy_on_select = true;
    cursor_blink_interval = 0;
    editor = "vim";
    hide_window_decorations = true;
    scrollback_pager_history_size = 1;
    update_check_interval = 0;
  };
  programs.kitty.extraConfig = "
  term xterm-256color
  window_padding_width 4
  tab_bar_style powerline
  tab_powerline_style slanted
  kitty_mod cmd
  map kitty_mod+t     new_tab_with_cwd
  confirm_os_window_close 0
  enable_audio_bell no
  macos_option_as_alt yes
  ";
  programs.kitty.theme = "Ayu";

  imports = [
    ./git.nix
    ./neovim
    ./yabai.nix
    ./zsh
  ];
}
