{ config, pkgs, lib, colorScheme, nix-colors, ... }:
let
  myKakoune = let
    config = pkgs.writeTextFile (rec {
      name = "kakrc.kak";
      destination = "/share/kak/autoload/${name}";
      text = ''
        set global ui_options ncurses_assistant=cat
      '';
    });
    kak-tree = pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
      pname = "kak-tree";
      version = "2022-03-05";
      src = pkgs.fetchFromGitHub {
        owner = "ul";
        repo = "kak-tree";
        rev = "b2b8539ddf6aee43abfd2131f15ed667ea3855f5";
        sha256 = "sha256-utc+DhtXePvFv2n54rvrU9WWBi/FgJL20L5vYeWD3zY=";
      };
      meta.homepage = "https://github.com/ul/kak-tree/";
    };
  in pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [ config parinfer-rust kak-tree ];
  };
in { home.packages = [ myKakoune ]; }
