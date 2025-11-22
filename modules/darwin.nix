{ pkgs, sensitive, ... }:
{
  imports = [
    ./aerospace.nix
  ];
  system.primaryUser = "rocko";
  users.users.${sensitive.lib.username} = {
    name = sensitive.lib.username;
    home = sensitive.lib.homeDirectory;
  };
  environment.systemPackages = with pkgs; [
    bat
    bottom
    cabal-install
    cachix
    cargo
    cmake
    elixir
    elixir-ls
    entr
    expect
    fd
    ffmpeg
    fx
    fzf
    gh
    gh-markdown-preview
    google-cloud-sdk
    gperftools
    gradle
    haskellPackages.zlib
    hyperfine
    insert-dylib
    jq
    moreutils
    mosh
    nixfmt-classic
    nixpkgs-fmt
    nil
    nodejs_24
    nodePackages.prettier
    onefetch
    pandoc
    pkg-config
    postgresql
    qbe
    ripgrep
    rust-analyzer
    rustc
    rustfmt
    silver-searcher
    tealdeer
    tmate
    tmux
    unixtools.watch
    wakatime-cli
    wasmtime
    wget
    xh
    yt-dlp
    cowsay
    curl
    eza
    fortune
    htop
    neofetch
    nnn
    tree
    (writeScriptBin "rebuild" ''
      cd /Users/rocko/GitClones/system
      git add -NA .
      darwin-rebuild switch --flake .#darwin $@
      cd -
    '')
  ];
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    brews = [
      "cava"
      "sketchybar"
    ];

    casks = [
      "anaconda"
      "ilspy"
      "vimr"
      "background-music"
      "ghostty"
    ];

    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "osx-cross/arm"
      "osx-cross/avr"
      "dimentium/autoraise"
      "FelixKratz/formulae"
      "qmk/qmk"
    ];
  };
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
  programs.nix-index.enable = true;
  programs.zsh.enable = true;
  nix.gc = {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 7d";
  };
  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
    access-tokens = github.com=${sensitive.lib.gh-acess-token}
    download-buffer-size = 16777216
  '';

  nix.settings.trusted-users = [ "rocko" ];

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
    "ghc-nix.cachix.org-1:wI8l3tirheIpjRnr2OZh6YXXNdK2fVQeOI4SVz/X8nA="
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    "fox:LUmYKVI6KAUFhj9F7JEHju9kvr4X+rXCGVKVK3+6Fdc="
  ];

  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://ghc-nix.cachix.org"
    "https://cache.iog.io"
  ];
  system.stateVersion = 4;
  ids.gids.nixbld = 350;
}
