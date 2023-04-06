{ nix-colors, ... }: rec {
  current = nix-colors.colorschemes.catppuccin-latte;
  override = "light";
  font = "Rec Mono Semicasual";

  pasque = {
    slug = "pasque";
    name = "Pasque";
    author = "Gabriel Fontes (https://github.com/Misterio77)";
    colors = {
      base00 = "271C3A";
      base01 = "100323";
      base02 = "3E2D5C";
      base03 = "5D5766";
      base04 = "BEBCBF";
      base05 = "DEDCDF";
      base06 = "EDEAEF";
      base07 = "BBAADD";
      base08 = "A92258";
      base09 = "918889";
      base0A = "804ead";
      base0B = "C6914B";
      base0C = "7263AA";
      base0D = "8E7DC6";
      base0E = "953B9D";
      base0F = "59325C";
    };
  };
  doomVibrant = {
    slug = "doom-vibrant";
    name = "Doom Vibrant";
    author = "Henrik Lissner <https://github.com/hlissner>";
    colors = {
      base00 = "2E3440";
      base01 = "3B4252";
      base02 = "434C5E";
      base03 = "4C566A";
      base04 = "D8DEE9";
      base05 = "E5E9F0";
      base06 = "ECEFF4";
      base07 = "8FBCBB";
      base08 = "BF616A";
      base09 = "D08770";
      base0A = "EBCB8B";
      base0B = "A3BE8C";
      base0C = "88C0D0";
      base0D = "81A1C1";
      base0E = "B48EAD";
      base0F = "5E81AC";
    };
  };
  darcula = {
    slug = "darcula";
    name = "Darcula";
    author = "jetbrains";
    colors = {
      base00 = "1a1a1a"; # background
      base01 = "323232"; # line cursor
      base02 = "323232"; # statusline
      base03 = "606366"; # line numbers
      base04 = "a4a3a3"; # selected line number
      base05 = "a9b7c6"; # foreground
      base06 = "ffc66d"; # function bright yellow
      base07 = "ffffff";
      base08 = "4eade5"; # cyan
      base09 = "689757"; # blue
      base0A = "bbb529"; # yellow
      base0B = "6a8759"; # string green
      base0C = "629755"; # comment green
      base0D = "9876aa"; # purple
      base0E = "cc7832"; # orange
      base0F = "808080"; # gray
    };
  };
  monokai-spectrum = {
    slug = "darcula-spectrum";
    name = "Darcula Filter Spectrum";
    author = "jetbrains";
    colors = {
      base00 = "1f1f1f";
      base01 = "383830";
      base02 = "49483e";
      base03 = "75715e";
      base04 = "a59f85";
      base05 = "f8f8f2";
      base06 = "f5f4f1";
      base07 = "f9f8f5";
      base08 = "f92672";
      base09 = "fd971f";
      base0A = "f4bf75";
      base0B = "a6e22e";
      base0C = "a1efe4";
      base0D = "66d9ef";
      base0E = "ae81ff";
      base0F = "cc6633";
    };
  };
}
