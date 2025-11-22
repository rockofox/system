{ config, pkgs, lib, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}
      local wezterm = require 'wezterm'
      local act = wezterm.action

      config.tab_bar_at_bottom = true;
      config.hide_tab_bar_if_only_one_tab = true;
      config.tab_max_width = 200;
      config.window_decorations = "RESIZE";
      config.front_end = "WebGpu"
      -- config.harfbuzz_features = { 'ss01', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt' }
      -- config.freetype_load_flags = 'NO_HINTING'

      config.keys = {
        {
          key = "l",
          mods = "SUPER",
          action = act.ActivatePaneDirection 'Prev',
        },
        {
          key = ";",
          mods = "SUPER",
          action = act.ActivatePaneDirection 'Next',
        },
        {
          key = "Enter",
          mods = "SUPER",
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = "Enter",
          mods = "SUPER|SHIFT",
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'k',
          mods = 'SUPER',
          action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'L', mods = 'CTRL' },
          },
        },
      }
      -- config.window_background_opacity = 0.75
      -- config.macos_window_background_blur = 20
      -- config.window_padding = {
      --   left = 0,
      --   right = 0,
      --   top = 0,
      --   bottom = 0,
      -- }

      return config
    '';
  };

  home.activation.reloadKittyConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    killall -m -SIGUSR1 kitty || true
  '';
}