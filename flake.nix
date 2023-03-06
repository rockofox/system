{
  description = "Rocko's system";

  inputs = {
    # Package sets
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
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
    nix-monitored = {
      url = "github:ners/nix-monitored";
      flake = false;
    };
    dosh.url = "github:rockofox/dosh";
  };

  outputs = { self, darwin, home-manager, nix-colors, nix-monitored, nixpkgs
    , ... }@inputs:
    let vars = import ./modules/vars.nix;
    in {
      darwin.manual.manpages.enable = false;

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
                    # nix-monitored = self.callPackage inputs.nix-monitored { };
                    # nixos-rebuild =
                    #   super.nixos-rebuild.override { nix = nix-monitored; };
                    # nix-direnv =
                    #   super.nix-direnv.override { nix = nix-monitored; };
                    # darwin-rebuild =
                    #   super.darwin-rebuild.override { nix = nix-monitored; };
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
