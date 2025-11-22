{ config, pkgs, lib, colorScheme, nix-colors, ... }:
let
  myKakoune = let
    config = pkgs.writeTextFile (rec {
      name = "kakrc.kak";
      destination = "/share/kak/autoload/${name}";
      text = ''
        set global ui_options ncurses_assistant=cat
        map global normal <c-p> ': fzf-mode<ret>'
      '';
    });
  in pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [ config parinfer-rust /* kak-tree */ kak-lsp fzf-kak ];
  };
in { home.packages = [ myKakoune ]; }
