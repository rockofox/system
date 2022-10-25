{ config, lib, pkgs, inputs, ... }: {
  documentation.enable = false;
  documentation.doc.enable = false;
  nix.useDaemon = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    bat
    curl
    entr
    exa
    expect
    fd
    fx
    fzf
    jq
    moreutils
    nixfmt
    nixfmt
    nixfmt
    nixos-rebuild
    ripgrep
    skhd
    tealdeer
    thefuck
    wget
    xh
    neofetch
    tmux
    tmate
    fortune
    cowsay
    # gpg
    htop
    dotnet-sdk
    nodePackages.prettier
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
      # "haskell-language-server"
      "gpg"
      # "haskell-stack"
      # "ghcup"
      "python"
    ];
    casks = [ "kitty" "anaconda" "ilspy" ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
      "koekeishiya/formulae"
    ];
  };

# Font support seems broken on macOS Ventura: https://github.com/LnL7/nix-darwin/issues/559
#  fonts = {
#    fontDir.enable = true;
#    fonts = with pkgs; [ nerdfonts recursive ];
#  };
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
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.gc.automatic = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # nix.build-users-group = "nixbld";
}
