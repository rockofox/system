{ pkgs, sensitive, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # portableServices.services.open-webui = {
  #   description = "Open Web UI";
  #   command = "/Users/rocko/GitClones/open-webui/venv/bin/open-webui";
  #   arguments = [
  #     "serve"
  #   ];
  #   user = "rocko";
  #   workingDirectory = "/Users/rocko/GitClones/open-webui";
  #   # logOutput = true;
  #   # logError = true;
  # };

  # launchd.daemons.silly-hello.serviceConfig = {
  #   description = "little web server that says hi on some port";
  #   command = "${pkgs.python3}/bin/python -m http.server 8089";
  #   environment = {
  #     PYTHONUNBUFFERED = "1";
  #   };
  #   workingDirectory = "/Users/rocko/GitClones/agnostic-services-ng";
  # };



  environment.systemPackages = with pkgs; [
    # ghc
    # mpv
    # nodePackages.generator-code
    # nodePackages.yo
    bat
    bottom
    cabal-install
    cachix
    cargo
    cmake
    cowsay
    curl
    dotnet-sdk
    elixir
    elixir-ls
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
    gitui
    google-cloud-sdk
    gperftools
    gradle
    haskellPackages.zlib
    htop
    hyperfine
    insert-dylib
    jq
    moreutils
    mosh
    neofetch
    nixfmt-classic
    nixpkgs-fmt
    nnn
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
    tree
    unixtools.watch
    wakatime
    wasmtime
    wget
    xh
    yt-dlp
    nil
    (writeScriptBin "rebuild" ''
      cd /Users/rocko/GitClones/system
      git add -NA .
      darwin-rebuild switch --flake .#darwin 
      cd -
    '')
  ];
  homebrew = {
    enable = true;
    # onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      # {
      #   name = "FelixKratz/formulae/fyabai";
      #   args = [ "HEAD" ];
      # }
      {
        name = "skhd";
      }
      # {
      #   name = "FelixKratz/formulae/borders";
      #   args = [ "HEAD" ];
      # }
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
    casks = [ "anaconda" "ilspy" "vimr" "background-music" "ghostty" ];
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
  # fonts.fonts = [];
  # fonts.fontDir.enable = false;

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

  programs.nix-index.enable = true;

  nix.gc = {
    automatic = true;
    interval.Day = 7; #Hours, minutes
    options = "--delete-older-than 7d";
  };


  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
    access-tokens = github.com=${sensitive.lib.gh-acess-token}
  '';

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
    "ghc-nix.cachix.org-1:wI8l3tirheIpjRnr2OZh6YXXNdK2fVQeOI4SVz/X8nA="
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    #    "https://cache.iog.io"
    # "https://cache.zw3rk.com"
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://ghc-nix.cachix.org"
    "https://cache.iog.io"
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Add ability to used TouchID for sudo authentication
  # security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # nix.build-users-group = "nixbld";
  ids.gids.nixbld = 350;
}
