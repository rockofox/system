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
    nix-colors.url = "github:rockofox/nix-colors";
    nix-monitored.url = "github:ners/nix-monitored";
    # dosh.url = "github:ners/dosh";
  };

  outputs = { self, darwin, /* dosh, */ home-manager, nix-colors, nix-monitored, nixpkgs
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
                    nix-monitored = nix-monitored.packages.${super.system}.nix-monitored;
                    # FIXME: Nix can't find the input for some reason
                    # dosh = dosh.packages.${super.system}.dosh;

                    # FIXME: nix-monitored breaks direnv for some reason
                    # nixos-rebuild =
                    #   super.nixos-rebuild.override { nix = nix-monitored; };
                    # nix-direnv =
                    #   super.nix-direnv.override { nix = nix-monitored; };
                    # darwin-rebuild =
                    #   super.darwin-rebuild.override { nix = nix-monitored; };

                    discord = super.discord.override { withOpenASAR = true; };
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
