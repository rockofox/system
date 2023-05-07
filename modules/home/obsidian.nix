{ config, pkgs, lib, colorScheme, nix-colors, ... }:
let
  vars = import ../vars.nix;
  colorSchemes = import ./colorschemes.nix { nix-colors = nix-colors; };
  colorScheme = colorSchemes.current;
in {
  /* OBSOLETE */
}
