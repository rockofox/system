{ config, lib, pkgs, inputs, sensitive, ... }:
{

  nix.useDaemon = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # nodePackages.generator-code
    # nodePackages.yo
    bat
    bottom
    cargo
    cmake
    cowsay
    curl
    dotnet-sdk
    entr
    expect
    eza
    fd
    ffmpeg
    fortune
    fx
    fzf
    gh
    gh-markdown-preview
    ghc
    gitui
    gperftools
    gradle
    htop
    hyperfine
    jq
    moreutils
    mosh
    neofetch
    nixfmt
    nixpkgs-fmt
    nnn
    nodePackages.prettier
    onefetch
    pandoc
    pkg-config
    postgresql
    ripgrep
    rust-analyzer
    rustc
    rustfmt
    silver-searcher
    stack
    tealdeer
    tmate
    tmux
    tree
    unixtools.watch
    wasmtime
    wget
    xh
    yt-dlp
  ];
  homebrew = {
    enable = true;
    # onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      {
        name = "FelixKratz/formulae/fyabai";
        args = [ "HEAD" ];
      }
      {
        name = "skhd";
      }
      {
        name = "FelixKratz/formulae/borders";
        args = [ "HEAD" ];
      }
      "cava"
      "sketchybar"
      # "qlcolorcode"
      # "qlstephen"
      # "qlmarkdown"
      # "quicklook-json"
      # "qlimagesize"
      # "suspicious-package"
      # "apparency"
      # "quicklookase"
      # "qlvideo"
    ];
    casks = [ "anaconda" "ilspy" "vimr" "background-music" ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      # "koekeishiya/formulae"
      # "rockofox/formulae"
      "osx-cross/arm"
      "osx-cross/avr"
      "dimentium/autoraise"
      "FelixKratz/formulae"
      "qmk/qmk"
    ];
  };
  # fonts.fonts = with pkgs; [ nerdfonts julia-mono lato jetbrains-mono ];
  # fonts.fontDir.enable = true;
  fonts.fonts = [];
  fonts.fontDir.enable = false;

  system = {
    defaults = {
      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
      };
    };
  };

  users.users.${sensitive.lib.username} = {
    name = sensitive.lib.username;
    home = sensitive.lib.homeDirectory;
  };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  services.activate-system.enable = true;
  programs.nix-index.enable = true;

  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = "--delete-older-than 30d";
  };


  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
    access-tokens = github.com=${sensitive.lib.gh-acess-token}
  '';
  nix.settings.auto-optimise-store = true;

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
  ];
  nix.settings.substituters = [
    #    "https://cache.iog.io"
    "https://cache.zw3rk.com"
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];

  # nix.package = pkgs.nix;

  # nix.monitored.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # nix.build-users-group = "nixbld";
}
