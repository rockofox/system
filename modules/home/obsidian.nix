{ config, pkgs, lib, colorScheme, nix-colors, ... }:
let
  colorSchemes = import ./colorschemes.nix { nix-colors = nix-colors; };
  colorScheme = colorSchemes.current;
in
{
  /* OBSOLETE */
}
