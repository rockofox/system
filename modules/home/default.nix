{ pkgs, lib, nix-colors, mySchemes, ... }:
let
  vars = import ../vars.nix;
  colorSchemes = import ./colorschemes.nix { nix-colors = nix-colors; };
in rec {
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

  # home.packages = with pkgs; [ nerdfonts julia-mono lato jetbrains-mono ];

  manual.manpages.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.home-manager.manual.manpages.enable = false;
  colorScheme = colorSchemes.current;
  # colorScheme = mySchemes.doomVibrant;

  programs.kitty.enable = true;
  programs.kitty.darwinLaunchOptions = [ "--single-instance" "--directory=~" ];
  programs.kitty.font.name = "Menlo";
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
  programs.kitty.extraConfig = ''
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
    allow_remote_control yes
    listen_on unix:/tmp/mykitty

    modify_font                     strikethrough_position 120%
    modify_font                     strikethrough_thickness 250%
    modify_font                     underline_position 125%
    modify_font                     underline_thickness 2px
    modify_font                     cell_height 105%
  '';
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
                rev = "96da97aa71ef4bf61feaa4d54395598e3bd7f0d3";
            }
          }/userChrome.css";
        :root {
            --toolbar-bgcolor: #${colorScheme.colors.base01};
        }

        menubar, toolbar, nav-bar, #TabsToolbar > *{
            background-color: #${colorScheme.colors.base00};
        }
      '';
      userContent = ''
        /* Hide scrollbar in FF Quantum */
        *{scrollbar-width:none !important}
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
      };
    };
  };

  imports = [
    ./autoraise.nix
    ./git.nix
    ./neovim
    ./obsidian.nix
    ./sketchybar.nix
    ./yabai.nix
    ./zsh
    nix-colors.homeManagerModule
  ];
}
