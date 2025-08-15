{
  description = "Rocko's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    # emacs-overlay pinned because https://github.com/nix-community/nix-doom-emacs/issues/409
    emacs-overlay.url =
      "github:nix-community/emacs-overlay/c16be6de78ea878aedd0292aa5d4a1ee0a5da501";
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sensitive = { url = "path:/Users/rocko/GitClones/sensitive"; };
    agnostic-services = { url = "path:/Users/rocko/GitClones/nix-agnostic-services-ng"; };
  };

  outputs = { self, darwin, home-manager, nix-colors, nix-doom-emacs
    , stylix, sensitive, nixpkgs-stable, nixvim, nixpkgs, agnostic-services, ... }@inputs: {
      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = sensitive.lib.arch;
          specialArgs = inputs;
          
          modules = [
            agnostic-services.darwinModules.default
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (self: super: {
                  # 2024-12-31
                  subversionClient = nixpkgs-stable.legacyPackages.${sensitive.lib.arch}.subversionClient;
                  discocss = super.discocss.overrideAttrs (prev: rec {
                    version = "0.3.1";
                    src = self.fetchFromGitHub {
                      owner = "bddvlpr";
                      repo = "discocss";
                      rev = "v${version}";
                      hash =
                        "sha256-BFTxgUy2H/T92XikCsUMQ4arPbxf/7a7JPRewGqvqZQ=";
                      };
                  });
                  swiftPackages = super.swiftPackages // {
                    clang = super.swiftPackages.clang.overrideAttrs (oldAttrs: {
                      postFixup = (oldAttrs.postFixup or "") + ''
                        sed -i "s/'-march=.*'//g" $out/nix-support/add-local-cc-cflags-before.sh
                      '';
                    });
                  };
                })
                (import inputs.emacs-overlay)
              ];
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.${sensitive.lib.username} = {
                imports = [ stylix.homeModules.stylix nixvim.homeManagerModules.nixvim ./modules/home ];
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
