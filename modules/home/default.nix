{ pkgs, lib, nix-colors, nix-doom-emacs, sensitive, ... }:
let
  override = "none";
  font = "Monaspace Neon";
  colorscheme = "rose-pine";
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
    foreground = "#${colorScheme.colors.base05}";
    background = "#${colorScheme.colors.base00}";
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
    hide_window_decorations titlebar-only
    allow_remote_control yes
    listen_on unix:/tmp/mykitty
    enabled_layouts fat:bias=75

    modify_font                     strikethrough_position 120%
    modify_font                     strikethrough_thickness 250%
    modify_font                     underline_position 125%
    modify_font                     underline_thickness 3px
    modify_font                     cell_height 105%
  '';
  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override { withVencord = true; };
    discordAlias = false;
    css = lib.mkDefault (lib.mkBefore ''
      /* ${colorScheme.slug} */
      .theme-dark, .theme-light {
        --background-primary:       #${colorScheme.colors.base00};
        --background-secondary:     #${colorScheme.colors.base01};
        --background-primary-alt:   #${colorScheme.colors.base02};
        --background-secondary-alt: #${colorScheme.colors.base02};
        --background-tertiary:      #${colorScheme.colors.base03};
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
          --toolbar-bgcolor: #${colorScheme.colors.base00} !important;
          --toolbar-color: #${colorScheme.colors.base05} !important;
          --toolbar-field-background-color: #${colorScheme.colors.base01} !important;
          --toolbar-field-color: #${colorScheme.colors.base05} !important;
          --input-bgcolor: #${colorScheme.colors.base01} !important;
          --input-color: #${colorScheme.colors.base05} !important;
        }
      '';
      userContent = ''
        /* Hide scrollbar in FF Quantum */
        *{scrollbar-width:none !important}

        @-moz-document url(about:home), url(about:newtab) {
          body {
            --newtab-background-color: ${colorScheme.colors.base00};
            --newtab-element-hover-color: ${colorScheme.colors.base01};
            --newtab-icon-primary-color: ${colorScheme.colors.base04};
            --newtab-search-border-color: ${colorScheme.colors.base01};
            --newtab-search-dropdown-color: ${colorScheme.colors.base00};
            --newtab-search-dropdown-header-color: ${colorScheme.colors.base00};
            --newtab-search-icon-color: ${colorScheme.colors.base04};
            --newtab-section-header-text-color: ${colorScheme.colors.base05};
            --newtab-snippets-background-color: ${colorScheme.colors.base01};
            --newtab-text-primary-color: ${colorScheme.colors.base05};
            --newtab-textbox-background-color: ${colorScheme.colors.base01};
            --newtab-textbox-border: ${colorScheme.colors.base01};
            --newtab-topsites-background-color: ${colorScheme.colors.base04};
            --newtab-topsites-label-color: ${colorScheme.colors.base05};
            --darkreader-neutral-background: #${colorScheme.colors.base00} !important;
            --darkreader-neutral-text: #${colorScheme.colors.base05} !important;
            --darkreader-selection-background: #${colorScheme.colors.base01} !important;
            --darkreader-selection-text: #${colorScheme.colors.base05} !important;
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
