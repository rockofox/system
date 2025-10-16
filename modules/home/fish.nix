{ config, pkgs, sensitive, ... }:
{
  home.packages = with pkgs; [
    fzf
    grc
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };
  programs.starship.enableFishIntegration = true;
}
