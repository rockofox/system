{ config, pkgs, lib, nix-colors, nix-doom-emacs, sensitive, ... }:

{
  imports = [
    nix-colors.homeManagerModule
    nix-doom-emacs.hmModule
    ./appearance
    ./applications
    ./terminal
    # ./window-management/yabai.nix
    # ./window-management/skhd.nix
    (import ./window-management/sketchybar.nix {
      inherit (config) colorScheme;
      font = "JetBrainsMono Nerd Font";
      inherit pkgs;
    })
    # ./autoraise.nix
    ./git.nix
    ./obsidian.nix
    ./tmux.nix
    ./zsh
    ./applications/nixvim-organized.nix
    (import ./colorschemes-misc.nix {
      inherit pkgs;
      inherit (config) colorScheme;
      font = "JetBrainsMono Nerd Font";
      inherit lib;
      inherit sensitive;
    })
  ];
  home.username = sensitive.lib.username;
  home.homeDirectory = sensitive.lib.homeDirectory;
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  manual.manpages.enable = false;
  home.packages = with pkgs; [ ];
  home.activation = {
    discocss = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.discocss}/bin/discocss --injectOnly || true
    '';

    wasienv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -d "${sensitive.lib.homeDirectory}/.wasienv" ]
      then
        curl https://raw.githubusercontent.com/wasienv/wasienv/master/install.sh | sh
      fi
    '';
  };
}
