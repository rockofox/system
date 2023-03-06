{ config, pkgs, lib, colorScheme, nix-colors, ... }:
let
  vars = import ../vars.nix;
  colorSchemes = import ./colorschemes.nix { nix-colors = nix-colors; };
  colorScheme = colorSchemes.current;
in {
  home.file.obsidian = {
    target = "${vars.obsidianVault}/.obsidian/snippets/base16.css";
    text = ''
        .theme-dark {
          --background-primary: #${colorScheme.colors.base00};
          --background-primary-alt: #${colorScheme.colors.base01};
          --background-secondary: #${colorScheme.colors.base01};
          --background-secondary-alt: #${colorScheme.colors.base01};
          --background-accent: #000;
          --background-modifier-border: #424958;
          --background-modifier-form-field: rgba(0, 0, 0, 0.3);
          --background-modifier-form-field-highlighted: rgba(0, 0, 0, 0.22);
          --background-modifier-box-shadow: rgba(0, 0, 0, 0.3);
          --background-modifier-success: #539126;
          --background-modifier-error: #3d0000;
          --background-modifier-error-rgb: 61, 0, 0;
          --background-modifier-error-hover: #470000;
          --background-modifier-cover: rgba(0, 0, 0, 0.6);
          --text-accent: #${colorScheme.colors.base08};
          --text-accent-hover: #${colorScheme.colors.base09};
          --text-normal: #${colorScheme.colors.base05};
          --text-muted: #${colorScheme.colors.base04};
          --text-faint: #${colorScheme.colors.base04};
          --text-error: #e16d76;
          --text-error-hover: #c9626a;
          --text-highlight-bg: rgba(255, 255, 0, 0.4);
          --text-selection: rgba(0, 122, 255, 0.2);
          --text-on-accent: #dcddde;
          --interactive-normal: #20242b;
          --interactive-hover: #353b47;
          --interactive-accent: #4c78cc;
          --interactive-accent-rgb: 76, 120, 204;
          --interactive-accent-hover: #5082df;
          --scrollbar-active-thumb-bg: rgba(255, 255, 255, 0.2);
          --scrollbar-bg: rgba(255, 255, 255, 0.05);
          --scrollbar-thumb-bg: rgba(255, 255, 255, 0.1);
          --panel-border-color: #18191e;
          --gray-1: #5C6370;
          --gray-2: #abb2bf;
          --red: #e06c75;
          --orange: #d19a66;
          --green: #98c379;
          --aqua: #56b6c2;
          --purple: #c678dd;
          --blue: #61afef;
          --yellow: #e5c07b;
      }
    '';
  };
}
