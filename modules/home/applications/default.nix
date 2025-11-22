{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.userSettings = builtins.fromJSON (builtins.readFile ../vscode-settings.json);
  };

  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override { withVencord = true; };
    discordAlias = false;
    css = lib.mkDefault (lib.mkBefore ''
    /* ${config.colorScheme.slug} */
    .theme-dark, .theme-light {
      --background-primary:       #${config.colorScheme.palette.base00};
      --background-secondary:     #${config.colorScheme.palette.base01};
      --background-primary-alt:   #${config.colorScheme.palette.base02};
      --background-secondary-alt: #${config.colorScheme.palette.base02};
      --background-tertiary:      #${config.colorScheme.palette.base03};
    }
    div[class^=nowPlayingColumn] {
      display: none !important;
    }
    '');
  };

  home.file.vencord-css = {
    executable = false;
    target = "Library/Application Support/Vencord/themes/base16.css";
    text = ''
    /* ${config.colorScheme.slug} */
    .theme-dark, .theme-light {
      --background-primary:       #${config.colorScheme.palette.base00};
      --background-secondary:     #${config.colorScheme.palette.base01};
      --background-primary-alt:   #${config.colorScheme.palette.base02};
      --background-secondary-alt: #${config.colorScheme.palette.base02};
      --background-tertiary:      #${config.colorScheme.palette.base03};
    }
    div[class^=nowPlayingColumn] {
      display: none !important;
    }
    '';
  };

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        true-color = true;
      };
    };
  };
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
}