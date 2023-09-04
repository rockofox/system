{
  description = "Rocko's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-monitored.url = "github:ners/nix-monitored";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # emacs-overlay pinned because https://github.com/nix-community/nix-doom-emacs/issues/409
    emacs-overlay.url = "github:nix-community/emacs-overlay/c16be6de78ea878aedd0292aa5d4a1ee0a5da501";
    stylix.url = "github:rockofox/stylix";
    sensitive = {
      url = "git+file:./sensitive";
    };
  };

  outputs =
    { self
    , darwin
    , home-manager
    , nix-colors
    , nix-doom-emacs
    , nix-monitored
    , stylix
    , neovim-nightly-overlay
    , sensitive
    , ...
    }@inputs:
    {
      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = sensitive.lib.arch;
          specialArgs = inputs;
          modules = [
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (self: super:
                  {
                    discocss = super.discocss.overrideAttrs (prev: rec {
                      version = "0.3.1";
                      src = self.fetchFromGitHub {
                        owner = "bddvlpr";
                        repo = "discocss";
                        rev = "v${version}";
                        hash = "sha256-BFTxgUy2H/T92XikCsUMQ4arPbxf/7a7JPRewGqvqZQ=";
                      };
                    });
                  })
                (import inputs.emacs-overlay)
                # (import inputs.neovim-nightly-overlay)
              ];
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${sensitive.lib.username} = {
                imports = [ stylix.homeManagerModules.stylix ./modules/home ];
              };
              home-manager.extraSpecialArgs = { inherit nix-colors; inherit nix-doom-emacs; inherit sensitive; };
            }
          ];
        };
      };
    };
}
