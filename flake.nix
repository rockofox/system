{
  description = "Rocko's system";

  inputs = {
    # nixos/nixpkgs/nixpkgs-unstable
    # nixpkgs.url = "github:nixos/nixpkgs?rev=a4d4fe8c5002202493e87ec8dbc91335ff55552c";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-monitored = {
      url = "github:ners/nix-monitored";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # emacs-overlay pinned because https://github.com/nix-community/nix-doom-emacs/issues/409
    emacs-overlay.url =
      "github:nix-community/emacs-overlay/c16be6de78ea878aedd0292aa5d4a1ee0a5da501";
    stylix.url = "github:danth/stylix";
    # ghcnix.url = "github:rockofox/ghc.nix#wasm-cross";
    sensitive = { url = "git+file:sensitive"; };
  };

  outputs = { self, darwin, home-manager, nix-colors, nix-doom-emacs
    , nix-monitored, stylix, neovim-nightly-overlay, sensitive, ... }@inputs: {
      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = sensitive.lib.arch;
          specialArgs = inputs;
          modules = [
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            # nix-monitored.darwinModules.default
            {
              nixpkgs.overlays = [
                (self: super: rec {
                  discocss = super.discocss.overrideAttrs (prev: rec {
                    version = "0.3.1";
                    src = self.fetchFromGitHub {
                      owner = "bddvlpr";
                      repo = "discocss";
                      rev = "v${version}";
                      hash =
                        "sha256-BFTxgUy2H/T92XikCsUMQ4arPbxf/7a7JPRewGqvqZQ=";
                    };
                    # nixos-rebuild = super.nixos-rebuild.override {
                    #   nix = super.nix-monitored;
                    # };
                    # nix-direnv = super.nix-direnv.override {
                    #   nix = super.nix-monitored;
                    # };
                  });
                  swiftPackages = super.swiftPackages // {
                    clang = super.swiftPackages.clang.overrideAttrs (oldAttrs: {
                      postFixup = (oldAttrs.postFixup or "") + ''
                        sed -i "s/'-march=.*'//g" $out/nix-support/add-local-cc-cflags-before.sh
                      '';
                    });
                  };
                  # base16-schemes = super.base16-schemes.overrideAttrs (prev: {
                  #   version = "20210611";
                  #   src = self.fetchFromGitHub {
                  #     owner = "rockofox";
                  #     repo = "schemes";
                  #     rev = "3950741";
                  #     hash = "sha256-9LmwYbtTxNFiP+osqRUbOXghJXpYvyvAwBwW80JMO7s=";
                  #   };
                  # });
                })
                (import inputs.emacs-overlay)
                # (inputs.neovim-nightly-overlay.overlay)
              ];
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.${sensitive.lib.username} = {
                imports = [ stylix.homeManagerModules.stylix ./modules/home ];
              };
              home-manager.extraSpecialArgs = {
                inherit nix-colors;
                inherit nix-doom-emacs;
                inherit sensitive;
              };
            }
          ];
        };
      };
    };
}
