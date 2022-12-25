{
  description = "Rocko's system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-monitored = {
      url = "github:ners/nix-monitored";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs-unstable, home-manager, nix-colors
    , nix-monitored, ... }@inputs:
    let

      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib)
        attrValues makeOverridable optionalAttrs singleton;

      lib = nixpkgs-unstable.lib;
      overlays = [ inputs.neovim-nightly-overlay.overlay ];

      vars = import ./modules/vars.nix;
    in {
      darwin.manual.manpages.enable = false;

      darwinConfigurations = {
        "darwin" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./modules/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (self: super: {
                  nix-monitored = self.callPackage inputs.nix-monitored { };
                  nixos-rebuild =
                    super.nixos-rebuild.override { nix = nix-monitored; };
                  nix-direnv =
                    super.nix-direnv.override { nix = nix-monitored; };
                  darwin-rebuild =
                    super.darwin-rebuild.override { nix = nix-monitored; };
                })
              ];
              nixpkgs.config.allowUnfree = true;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${vars.username} = {
                imports = [ ./modules/home ];
              };
              home-manager.extraSpecialArgs = { inherit nix-colors; };
            }
          ];
        };
      };
    };
}

