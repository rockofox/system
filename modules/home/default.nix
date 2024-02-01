{ pkgs, lib, nix-colors, nix-doom-emacs, sensitive, ... }:
let
  override = "none";
  font = "Monaspace Neon Var";
  colorscheme = "gruber";
in
rec {
  colorScheme = nix-colors.colorschemes.${colorscheme};
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
  stylix.autoEnable = false;
  stylix.targets.vscode.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.vim.enable = false;
  stylix.targets.helix.enable = true;
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}
      local wezterm = require 'wezterm'
      local act = wezterm.action

      config.tab_bar_at_bottom = true;
      config.hide_tab_bar_if_only_one_tab = true;
      config.tab_max_width = 200;
      config.window_decorations = "RESIZE";
      config.harfbuzz_features = { 'ss01', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'dlig' }
      config.keys = {
        {
          key = "[",
          mods = "SUPER",
          action = act.ActivatePaneDirection 'Prev',
        },
        {
          key = "]",
          mods = "SUPER",
          action = act.ActivatePaneDirection 'Next',
        },
        {
          key = "Enter",
          mods = "SUPER",
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = "Enter",
          mods = "SUPER|SHIFT",
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'k',
          mods = 'SUPER',
          action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'L', mods = 'CTRL' },
          },
        },
      }

      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }

      return config
    '';
  };
  stylix.targets.wezterm.enable = true;
  stylix.fonts = {
    monospace = {
      package = pkgs.hello;
      name = font;
    };
    sizes = {
      applications = 12;
      terminal = 15;
    };
  };


  # paths it should manage.
  home.username = sensitive.lib.username;
  home.homeDirectory = sensitive.lib.homeDirectory;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.activation = {
    discocss = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.discocss}/bin/discocss --injectOnly || true
    '';
    reloadKittyConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      killall -m -SIGUSR1 kitty || true
    '';
    setMacosColorScheme = lib.hm.dag.entryAfter [ "writeBoundary" ]
      (if lib.strings.hasInfix "light" colorScheme.slug || override == "light" && override != "dark" then
        ''
          osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' || true
        ''
      else
        ''
          osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' || true
        '');
    wasienv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -d "${sensitive.lib.homeDirectory}/.wasienv" ]
      then
        curl https://raw.githubusercontent.com/wasienv/wasienv/master/install.sh | sh
      fi
    '';
  };

  home.packages = with pkgs; [ ];

  manual.manpages.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
  };


  programs.kitty.enable = true;
  programs.kitty.darwinLaunchOptions = [ "--single-instance" "--directory=~" ];
  programs.kitty.settings = {
    # background_opacity = "0.85";
    foreground = "#${colorScheme.palette.base05}";
    background = "#${colorScheme.palette.base00}";
    copy_on_select = true;
    cursor_blink_interval = 0;
    editor = "vim";
    hide_window_decorations = true;
    scrollback_pager_history_size = 1;
    update_check_interval = 0;
  };
  programs.kitty.extraConfig = ''
    window_padding_width 4
    tab_bar_style powerline
    tab_powerline_style slanted
    kitty_mod cmd
    map kitty_mod+t     new_tab_with_cwd
    map kitty_mod+enter new_window_with_cwd
    confirm_os_window_close 0
    enable_audio_bell no
    macos_option_as_alt yes
    hide_window_decorations yes
    allow_remote_control yes
    listen_on unix:/tmp/mykitty
    enabled_layouts fat:bias=75
    text_composition_strategy legacy
    font_features    MonaspaceArgonVar-Bold         +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-BoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-ExtraBold  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-ExtraBoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-ExtraLightItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-Italic       +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-Light        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-LightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-Medium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-MediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-SemiWideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceArgonVar-WideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt

    font_features    MonaspaceKyrptonVar-Bold         +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-BoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKyrptonVar-ExtraBold  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-ExtraBoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-ExtraLightItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-Italic       +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-Light        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-LightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-Medium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-MediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-SemiWideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceKryptonVar-WideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt

    font_features    MonaspaceNeonVar-Bold         +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-BoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-ExtraBold  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-ExtraBoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-ExtraLightItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-Italic       +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-Light        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-LightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-Medium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-MediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-SemiWideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceNeonVar-WideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt

    font_features    MonaspaceRadonVar-Bold         +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-BoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-ExtraBold  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-ExtraBoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-ExtraLightItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-Italic       +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-Light        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-LightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-Medium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-MediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-SemiWideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceRadonVar-WideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt

    font_features    MonaspaceXenonVar-Bold         +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-BoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-ExtraBold  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-ExtraBoldItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-ExtraLightItalic  +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-Italic       +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-Light        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-LightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-Medium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-MediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-SemiWideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideExtraBold        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideExtraBoldItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideExtraLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideExtraLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideLight        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideLightItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideMedium        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideMediumItalic        +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideRegular      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideSemiBold      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt
    font_features    MonaspaceXenonVar-WideSemiBoldItalic      +ss01 +ss03 +ss04 +ss05 +ss06 +ss07 +calt


    modify_font                     strikethrough_position 120%
    modify_font                     strikethrough_thickness 250%
    modify_font                     underline_position 125%
    modify_font                     underline_thickness 3px
    # modify_font                     cell_height 105%
    '';
    programs.discocss = {
      enable = true;
      discordPackage = pkgs.discord.override { withVencord = true; };
      discordAlias = false;
      css = lib.mkDefault (lib.mkBefore ''
      /* ${colorScheme.slug} */
      .theme-dark, .theme-light {
        --background-primary:       #${colorScheme.palette.base00};
        --background-secondary:     #${colorScheme.palette.base01};
        --background-primary-alt:   #${colorScheme.palette.base02};
        --background-secondary-alt: #${colorScheme.palette.base02};
        --background-tertiary:      #${colorScheme.palette.base03};
      }
      div[class^=nowPlayingColumn] {
        display: none !important;
      }
      '');
    };

    programs.firefox = {
      enable = true;
      package = pkgs.hello;
      profiles.clean = {
        isDefault = false;
        id = 1;
      };
      profiles.default = {
        isDefault = true;
        userChrome = ''
        @import "${
          builtins.fetchGit {
            url = "https://github.com/rockofox/firefox-minima";
            ref = "main";
            rev = "932a99851b5f2db8b58aa456e5d897e278c69574";
          }
        }/userChrome.css";
        /* TODO: Base16 */
        :root {
          --toolbar-bgcolor: #${colorScheme.palette.base00} !important;
          --toolbar-color: #${colorScheme.palette.base05} !important;
          --toolbar-field-background-color: #${colorScheme.palette.base01} !important;
          --toolbar-field-color: #${colorScheme.palette.base05} !important;
          --input-bgcolor: #${colorScheme.palette.base01} !important;
          --input-color: #${colorScheme.palette.base05} !important;
        }
        '';
        userContent = ''
        /* Hide scrollbar in FF Quantum */
        *{scrollbar-width:none !important}

        @-moz-document url(about:home), url(about:newtab) {
          body {
            --newtab-background-color: ${colorScheme.palette.base00};
            --newtab-element-hover-color: ${colorScheme.palette.base01};
            --newtab-icon-primary-color: ${colorScheme.palette.base04};
            --newtab-search-border-color: ${colorScheme.palette.base01};
            --newtab-search-dropdown-color: ${colorScheme.palette.base00};
            --newtab-search-dropdown-header-color: ${colorScheme.palette.base00};
            --newtab-search-icon-color: ${colorScheme.palette.base04};
            --newtab-section-header-text-color: ${colorScheme.palette.base05};
            --newtab-snippets-background-color: ${colorScheme.palette.base01};
            --newtab-text-primary-color: ${colorScheme.palette.base05};
            --newtab-textbox-background-color: ${colorScheme.palette.base01};
            --newtab-textbox-border: ${colorScheme.palette.base01};
            --newtab-topsites-background-color: ${colorScheme.palette.base04};
            --newtab-topsites-label-color: ${colorScheme.palette.base05};
            --darkreader-neutral-background: #${colorScheme.palette.base00} !important;
            --darkreader-neutral-text: #${colorScheme.palette.base05} !important;
            --darkreader-selection-background: #${colorScheme.palette.base01} !important;
            --darkreader-selection-text: #${colorScheme.palette.base05} !important;
          }
        }
        '';
        settings = {
        # enable chrome/* customizations
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # disable toolkit telemetry stuff
        # https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
        "toolkit.telemetry.unified" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;

        # reload last session on startup, but still warn on quit
        "browser.startup.page" = 3;
        "browser.warnOnQuit" = true;
        "browser.sessionstore.warnOnQuit" = true;

        # no home or new tab page
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;

        "browser.toolbars.bookmarks.visibility" = "never";

        # disable first-run onboarding
        "browser.aboutwelcome.enabled" = false;

        # enable "browser toolbox" for inspecting browser chrome
        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;

        "devtools.inspector.showUserAgentStyles" = true;

        "devtools.theme" = "dark";

        # disable all the autofill prompts
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "signon.rememberSignons" = false;

        "general.smoothscroll" = false;

        # disable spellcheck for form inputs
        "layout.spellcheckDefault" = 0;

        # when you open a link image or media in a new tab switch to it immediately
        "browser.tabs.loadInBackground" = false;

        "extensions.pocket.enabled" = false;
        "browser.tabs.firefox-view" = false;
        "svg.context-properties.content.enabled" = true;
      };
    };
  };
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        true-color = true;
      };
    };
  };

  imports = [
    nix-colors.homeManagerModule
    nix-doom-emacs.hmModule
    ./autoraise.nix
    (import ./colorschemes-misc.nix {
      inherit pkgs;
      inherit colorScheme;
      inherit font;
      inherit lib;
      inherit sensitive;
    })
    # (import ./emacs {
    #   inherit colorScheme;
    #   inherit font;
    #   inherit pkgs;
    #   inherit lib;
    # })
    ./git.nix
    # ./kakoune.nix
    ./neovim
    ./obsidian.nix
    (import ./sketchybar.nix {
      inherit colorScheme;
      inherit font;
      inherit pkgs;
    })
    ./yabai.nix
    ./tmux.nix
    ./zsh
  ];
}
