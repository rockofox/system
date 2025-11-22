{ config, pkgs, lib, ... }:
{
  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      shift + alt - 0 : /opt/homebrew/bin/yabai -m space --balance
      shift + alt - up : /opt/homebrew/bin/yabai -m window --grid 1:1:0:0:1:1
      shift + alt - left : /opt/homebrew/bin/yabai -m window --grid 1:2:0:0:1:1
      alt - v : /opt/homebrew/bin/yabai -m space --focus prev
      alt - b : /opt/homebrew/bin/yabai -m space --focus next
      shift + alt - v : /opt/homebrew/bin/yabai -m window --space prev; /opt/homebrew/bin/yabai -m space --focus prev
      shift + alt - b : /opt/homebrew/bin/yabai -m window --space next; /opt/homebrew/bin/yabai -m space --focus next
      cmd + alt - x : /opt/homebrew/bin/yabai -m space --focus recent
      cmd + alt - 1 : /opt/homebrew/bin/yabai -m space --focus 1
      shift + cmd - 2 : /opt/homebrew/bin/yabai -m window --space 2; /opt/homebrew/bin/yabai -m space --focus 2
      ctrl + alt - z : /opt/homebrew/bin/yabai -m display --focus prev
      ctrl + alt - 3 : /opt/homebrew/bin/yabai -m display --focus 3
      ctrl + cmd - c : /opt/homebrew/bin/yabai -m window --display next; /opt/homebrew/bin/yabai -m display --focus next
      ctrl + cmd - 1 : /opt/homebrew/bin/yabai -m window --display 1; /opt/homebrew/bin/yabai -m display --focus 1
      shift + ctrl - a : /opt/homebrew/bin/yabai -m window --move rel:-20:0
      shift + ctrl - s : /opt/homebrew/bin/yabai -m window --move rel:0:20
      shift + alt - a : /opt/homebrew/bin/yabai -m window --resize left:-20:0
      shift + alt - w : /opt/homebrew/bin/yabai -m window --resize top:0:-20
      shift + cmd - s : /opt/homebrew/bin/yabai -m window --resize bottom:0:-20
      shift + cmd - w : /opt/homebrew/bin/yabai -m window --resize top:0:20
      ctrl + lalt - n : /opt/homebrew/bin/yabai -m window --insert west
      ctrl + lalt - i : /opt/homebrew/bin/yabai -m window --insert south
      ctrl + lalt - o : /opt/homebrew/bin/yabai -m window --insert north
      ctrl + lalt - h : /opt/homebrew/bin/yabai -m window --insert east
      alt - d : /opt/homebrew/bin/yabai -m window --toggle zoom-parent
      alt - f : /opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen
      alt - e : /opt/homebrew/bin/yabai -m window --toggle split
      alt - t : /opt/homebrew/bin/yabai -m space --layout $(/opt/homebrew/bin/yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')
      lalt - n : /opt/homebrew/bin/yabai -m window --focus west || /opt/homebrew/bin/yabai -m display --focus west
      lalt - i : /opt/homebrew/bin/yabai -m window --focus south || /opt/homebrew/bin/yabai -m display --focus south
      lalt - o : /opt/homebrew/bin/yabai -m window --focus north || /opt/homebrew/bin/yabai -m display --focus north
      lalt - h : /opt/homebrew/bin/yabai -m window --focus east || /opt/homebrew/bin/yabai -m display --focus east
      alt + shift - n : /opt/homebrew/bin/yabai -m window --swap west || $(/opt/homebrew/bin/yabai -m window --display west; /opt/homebrew/bin/yabai -m display --focus west)
      alt + shift - i : /opt/homebrew/bin/yabai -m window --swap south || $(/opt/homebrew/bin/yabai -m window --display south; /opt/homebrew/bin/yabai -m display --focus south)
      alt + shift - o : /opt/homebrew/bin/yabai -m window --swap north || $(/opt/homebrew/bin/yabai -m window --display north; /opt/homebrew/bin/yabai -m display --focus north)
      alt + shift - h : /opt/homebrew/bin/yabai -m window --swap east || $(/opt/homebrew/bin/yabai -m window --display east; /opt/homebrew/bin/yabai -m display --focus east)

      ctrl - return : ${pkgs.wezterm}/bin/wezterm
      ctrl - q : open http://
      ctrl + shift - e : open ~
      alt + ctrl - e : /Applications/Neovide.app/Contents/MacOS/neovide --frame none --multigrid

      ctrl - 1 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 1"
      ctrl - 2 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 2"
      ctrl - 3 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 3"
      ctrl - 4 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 4"
      ctrl - 5 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 5"
      ctrl - 6 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 6"
      ctrl - 7 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 7"
      ctrl - 8 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 8"
      ctrl - 9 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 9"
      ctrl - 0 : /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 0"

      ctrl + shift - 1 : /opt/homebrew/bin/yabai -m window --space 1
      ctrl + shift - 2 : /opt/homebrew/bin/yabai -m window --space 2
      ctrl + shift - 3 : /opt/homebrew/bin/yabai -m window --space 3
      ctrl + shift - 4 : /opt/homebrew/bin/yabai -m window --space 4
      ctrl + shift - 5 : /opt/homebrew/bin/yabai -m window --space 5
      ctrl + shift - 6 : /opt/homebrew/bin/yabai -m window --space 6
      ctrl + shift - 7 : /opt/homebrew/bin/yabai -m window --space 7
      ctrl + shift - 8 : /opt/homebrew/bin/yabai -m window --space 8
      ctrl + shift - 9 : /opt/homebrew/bin/yabai -m window --space 9
      ctrl + shift - 0 : /opt/homebrew/bin/yabai -m window --space 10

      ctrl - t : /opt/homebrew/bin/yabai -m window --toggle float
    '';
  };
}