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
  };

  outputs = { self, darwin, home-manager, nix-colors, nix-doom-emacs, nix-monitored
    , stylix, neovim-nightly-overlay, ... }@inputs:
    let vars = import ./modules/vars.nix;
    in {
      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = inputs;
          modules = [
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (self: super:
                  {
                    discocss = super.discocss.overrideAttrs (prev: {
                      src = self.fetchFromGitHub {
                        owner = "rockofox";
                        repo = "discocss";
                        rev = "2ce50e3d79d7c45d704647414b7248dcb9846a01";
                        sha256 = "sha256-dovk50Q0qAQ59ZrIDazvUluJyaKsUiS3MPqrUwaIaYQ=";
                      };
                    });
                  })
                  (import inputs.emacs-overlay)
                  # (import inputs.neovim-nightly-overlay)
              ];
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${vars.username} = {
                imports = [ stylix.homeManagerModules.stylix ./modules/home ];
              };
              home-manager.extraSpecialArgs = { inherit nix-colors; inherit nix-doom-emacs; };
            }
          ];
        };
      };
    };
}
