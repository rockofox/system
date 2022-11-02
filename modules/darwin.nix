{ config, lib, pkgs, inputs, ... }: {
  documentation.enable = false;
  documentation.doc.enable = false;
  nix.useDaemon = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    bat
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
    nixos-rebuild
    nodePackages.prettier
    ripgrep
    skhd
    tealdeer
    tmate
    tmux
    wget
    xh
  ];
  homebrew = {
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
    };
    brews = [
      "yabai"
      "skhd"
      "gpg"
      "python"
      "qmk/qmk/qmk"
    ];
    casks = [ "anaconda" "ilspy" ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
      "koekeishiya/formulae"
      "osx-cross/arm"
      "osx-cross/avr"
      "qmk/qmk"
    ];
  };

  system = {
    defaults = {
      NSGlobalDomain = { NSAutomaticSpellingCorrectionEnabled = false; };
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
      };
    };
  };

  users.users.rocko = {
        name = "rocko";
        home = "/Users/rocko";
    };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    auto-optimise-store = true
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

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # nix.build-users-group = "nixbld";
}
