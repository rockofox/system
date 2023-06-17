{
  description = "Rocko's system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    # dosh.url = "github:ners/dosh";
    stylix.url = "github:rockofox/stylix";
  };

  outputs = { darwin, home-manager, nix-colors, nix-doom-emacs, nix-monitored
    , stylix, ... }@inputs:
    let vars = import ./modules/vars.nix;
    in {
      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (self: super:
                  {
                    nix-monitored = nix-monitored.packages.${super.system}.nix-monitored;
                    # dosh = dosh.packages.${super.system}.dosh;
                    nixos-rebuild =
                      super.nixos-rebuild.override { nix = nix-monitored; };
                    # nix-direnv =
                      # super.nix-direnv.override { nix = nix-monitored; };
                    darwin-rebuild =
                      super.darwin-rebuild.override { nix = nix-monitored; };
                    helix = super.helix.overrideAttrs (prev: {
                      src = self.fetchFromGitHub {
                        owner = "AlexanderDickie";
                        repo = "helix";
                        rev = "360b69bf5d8ca7f7f6dca92d657e309a96e843e8";
                        sha256 = "sha256-7g5T2rQgD8LTmeWNcpEHFHLPE6L1jmlzXdXHEGWzuC0";
                      };
                    });
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
