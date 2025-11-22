{ config, pkgs, lib, nix-colors, ... }:
let
  override = "dark";
  font = "JetBrainsMono Nerd Font";
  colorscheme-dark = "horizon-terminal-dark";
  colorscheme-light = "horizon-terminal-light";
  colorscheme-default = colorscheme-dark;
in
{
  stylix.base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/${colorscheme-default}.yaml";
  stylix.polarity = "dark";
  stylix.autoEnable = false;
  colorScheme = {
    palette = config.lib.stylix.colors;
    slug = colorscheme-default;
  };
  stylix.enable = true;
  stylix.targets.vscode.enable = true;
  stylix.targets.wezterm.enable = true;
  stylix.targets.vim.enable = true;
  stylix.targets.helix.enable = true;
  stylix.fonts = {
    monospace = {
      package = pkgs.hello;
      name = font;
    };
    sizes = {
      applications = 15;
      terminal = 15;
    };
  };
  home.activation.setMacosColorScheme = lib.hm.dag.entryAfter [ "writeBoundary" ]
    (if lib.strings.hasInfix "light" config.colorScheme.slug || override == "light" && override != "dark" then
      ''
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' || true
      ''
    else
      ''
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' || true
      '');
}