{ nix-colors, ... }:
rec {
  current = nix-colors.colorSchemes.seti;
  pasque = {
    slug = "pasque";
    name = "Pasque";
    author = "Gabriel Fontes (https://github.com/Misterio77)";
    colors = {
      base00 = "#271C3A";
      base01 = "#100323";
      base02 = "#3E2D5C";
      base03 = "#5D5766";
      base04 = "#BEBCBF";
      base05 = "#DEDCDF";
      base06 = "#EDEAEF";
      base07 = "#BBAADD";
      base08 = "#A92258";
      base09 = "#918889";
      base0A = "#804ead";
      base0B = "#C6914B";
      base0C = "#7263AA";
      base0D = "#8E7DC6";
      base0E = "#953B9D";
      base0F = "#59325C";
    };
  };
  doomVibrant = {
    slug = "doom-vibrant";
    name = "Doom Vibrant";
    author = "Henrik Lissner <https://github.com/hlissner>";
    colors = {
      base00 = "#2E3440";
      base01 = "#3B4252";
      base02 = "#434C5E";
      base03 = "#4C566A";
      base04 = "#D8DEE9";
      base05 = "#E5E9F0";
      base06 = "#ECEFF4";
      base07 = "#8FBCBB";
      base08 = "#BF616A";
      base09 = "#D08770";
      base0A = "#EBCB8B";
      base0B = "#A3BE8C";
      base0C = "#88C0D0";
      base0D = "#81A1C1";
      base0E = "#B48EAD";
      base0F = "#5E81AC";
    };
  };
}
