{ config, lib, pkgs, inputs, ... }:
let vars = import ./vars.nix;
in {
  documentation.enable = false;
  documentation.doc.enable = false;
  nix.useDaemon = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    bat
    bottom
    cowsay
    curl
    dotnet-sdk
    entr
    exa
    expect
    fd
    fortune
    fx
    fzf
    gh
    gitui
    htop
    jq
    moreutils
    neofetch
    nixfmt
    nodePackages.prettier
    postgresql
    ripgrep
    silver-searcher
    skhd
    tealdeer
    tmate
    tmux
    tree
    unixtools.watch
    wget
    xh
  ];
  homebrew = {
    enable = true;
    onActivation = { autoUpdate = false; };
    brews = [
      {
        name = "yabai";
        start_service = true;
        restart_service = "changed";
      }
      {
        name = "skhd";
        start_service = true;
        restart_service = "changed";
      }
      "cava"
      "sketchybar"
    ];
    casks = [ "anaconda" "ilspy" "vimr" "background-music" ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
      "koekeishiya/formulae"
      "osx-cross/arm"
      "osx-cross/avr"
      "dimentium/autoraise"
      "FelixKratz/formulae"
      "qmk/qmk"
    ];
  };
  fonts.fonts = with pkgs; [ nerdfonts julia-mono lato jetbrains-mono ];
  fonts.fontDir.enable = true;

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

  users.users.${vars.username} = {
    name = vars.username;
    home = vars.homeDirectory;
  };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.gc.automatic = true;
  nix.gc.interval = { Day = 1; };
  nix.gc.options = "--delete-older-than 1d";

  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    auto-optimise-store = false
    experimental-features = nix-command flakes
  '';

  # Binary Cache for Haskell.nix  
  nix.settings.trusted-public-keys = [
    #    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.substituters = [
    #    "https://cache.iog.io"
    "https://cache.zw3rk.com"
  ];

  # nix.package = pkgs.nix;
  # nix.package = pkgs.nix-monitored;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # nix.build-users-group = "nixbld";
}
