{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
      /opt/homebrew/bin/yabai -m config mouse_follows_focus          on
      /opt/homebrew/bin/yabai -m config focus_follows_mouse          autoraise
      /opt/homebrew/bin/yabai -m config window_origin_display        default
      /opt/homebrew/bin/yabai -m config window_placement             second_child
      /opt/homebrew/bin/yabai -m config window_shadow                off
      /opt/homebrew/bin/yabai -m config window_opacity               off
      /opt/homebrew/bin/yabai -m config window_opacity_duration      0.0
      /opt/homebrew/bin/yabai -m config active_window_opacity        1.0
      /opt/homebrew/bin/yabai -m config normal_window_opacity        0.90
      # /opt/homebrew/bin/yabai -m config window_border_radius         10
      # /opt/homebrew/bin/yabai -m config active_window_border_color   0xff${config.colorScheme.palette.base09}
      # /opt/homebrew/bin/yabai -m config normal_window_border_color   0xff${config.colorScheme.palette.base00}
      # /opt/homebrew/bin/yabai -m config insert_feedback_color        0xff${config.colorScheme.palette.base05}

      # borders "active_color=gradient(top_right=0xff${config.colorScheme.palette.base08},bottom_left=0xff${config.colorScheme.palette.base0A})" inactive_color=0xff${config.colorScheme.palette.base00} width=5.0 style=s order=above 2>/dev/null 1>&2 &

      /opt/homebrew/bin/yabai -m config split_ratio                  0.50
      /opt/homebrew/bin/yabai -m config auto_balance                 off
      /opt/homebrew/bin/yabai -m config mouse_modifier               ctrl
      /opt/homebrew/bin/yabai -m config mouse_action1                move
      /opt/homebrew/bin/yabai -m config mouse_action2                resize
      /opt/homebrew/bin/yabai -m config mouse_drop_action            swap
      /opt/homebrew/bin/yabai -m config external_bar all:25:0

      # general space settings
      /opt/homebrew/bin/yabai -m config layout                       bsp
      # /opt/homebrew/bin/yabai -m config top_padding                  18
      /opt/homebrew/bin/yabai -m config bottom_padding               18
      /opt/homebrew/bin/yabai -m config left_padding                 18
      /opt/homebrew/bin/yabai -m config right_padding                18
      /opt/homebrew/bin/yabai -m config window_gap                   18

      # system floating windows
      # /opt/homebrew/bin/yabai -m rule --add app="^Finder$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^System Preferences$" manage=off
      /opt/homebrew/bin/yabai -m rule --add title='Preferences$' manage=off
      /opt/homebrew/bin/yabai -m rule --add title='Settings$' manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^System Information$" manage=off
      /opt/homebrew/bin/yabai -m rule --add title="Software Update$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^App Store$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Disk Utility$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Activity Monitor$" manage=off
      /opt/homebrew/bin/yabai -m rule --add title='Archive Utility$' manage=off
      /opt/homebrew/bin/yabai -m rule --add title='Bin$' manage=off
      /opt/homebrew/bin/yabai -m rule --add title="^Opening*" manage=off

      # 3rd party
      /opt/homebrew/bin/yabai -m rule --add app="^Alfred Preferences$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="UTM" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Stats$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Hidden Bar$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Amphetamine$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^zoom.us$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Docker Desktop$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Spaceman$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Steam$" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="Photoshop" manage=off
      /opt/homebrew/bin/yabai -m rule --add app="^Ghidra$" manage=off

      /opt/homebrew/bin/yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="App Store" app="^App Store$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="mpv" app="^mpv$" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="Software Update" title="Software Update" manage=off
      /opt/homebrew/bin/yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off

      # /opt/homebrew/bin/yabai -m config --space 2 layout float
      # /opt/homebrew/bin/yabai -m config --space 2  focus_follows_mouse off

      # Broken for some reason
      # /opt/homebrew/bin/yabai -m signal --add event=window_created action='/opt/homebrew/bin/yabai -m query --windows --window $YABAI_WINDOW_ID | ${pkgs.jq} -er ".\"can-resize\" or .\"is-floating\"" || yabai -m window $YABAI_WINDOW_ID --toggle float'

      /opt/homebrew/bin/yabai -m signal --add event=dock_did_restart action="sudo /opt/homebrew/bin/yabai --load-sa"
      sudo /opt/homebrew/bin/yabai --load-sa

      borders active_color=0xff${config.colorScheme.palette.base08} inactive_color=0xff${config.colorScheme.palette.base00} width=3.0 style=s 2>/dev/null 1>&2 &

      # sketchybar 2>/dev/null 1>&2 &

      echo "yabai configuration loaded.."
    '';
  };
  home.file.stack = {
    target = ".config/skhd/stack";
    executable = true;
    text = ''
      #!/usr/bin/env bash

      dir=$1
      # dir should be one of east,west,north,south

      window=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.id') 

      # Stack this window onto existing stack if possible
      /opt/homebrew/bin/yabai -m window $dir --stack $window 
      if [[ $? -ne 0 ]]; then
      # otherwise, float and un-float this window to reinsert it into 
      # the bsp tree as a new window
      /opt/homebrew/bin/yabai -m window --insert $dir
      /opt/homebrew/bin/yabai -m window $window --toggle float 
      /opt/homebrew/bin/yabai -m window $window --toggle float
      fi
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # balance size of windows
      shift + alt - 0 : /opt/homebrew/bin/yabai -m space --balance

      # make floating window fill screen
      shift + alt - up     : /opt/homebrew/bin/yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      shift + alt - left   : /opt/homebrew/bin/yabai -m window --grid 1:2:0:0:1:1

      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)

      # next / previous space
      alt - v : /opt/homebrew/bin/yabai -m space --focus prev
      alt - b : /opt/homebrew/bin/yabai -m space --focus next

      # move window to next / previous space
      shift + alt - v : /opt/homebrew/bin/yabai -m window --space prev; /opt/homebrew/bin/yabai -m space --focus prev
      shift + alt - b : /opt/homebrew/bin/yabai -m window --space next; /opt/homebrew/bin/yabai -m space --focus next

      # fast focus desktop
      cmd + alt - x : /opt/homebrew/bin/yabai -m space --focus recent
      cmd + alt - 1 : /opt/homebrew/bin/yabai -m space --focus 1

      # send window to desktop and follow focus
      # shift + cmd - z : /opt/homebrew/bin/yabai -m window --space next; /opt/homebrew/bin/yabai -m space --focus next
      shift + cmd - 2 : /opt/homebrew/bin/yabai -m window --space  2; /opt/homebrew/bin/yabai -m space --focus 2

      # focus monitor
      ctrl + alt - z  : /opt/homebrew/bin/yabai -m display --focus prev
      ctrl + alt - 3  : /opt/homebrew/bin/yabai -m display --focus 3

      # send window to monitor and follow focus
      ctrl + cmd - c  : /opt/homebrew/bin/yabai -m window --display next; /opt/homebrew/bin/yabai -m display --focus next
      ctrl + cmd - 1  : /opt/homebrew/bin/yabai -m window --display 1; /opt/homebrew/bin/yabai -m display --focus 1

      # move floating window
      shift + ctrl - a : /opt/homebrew/bin/yabai -m window --move rel:-20:0
      shift + ctrl - s : /opt/homebrew/bin/yabai -m window --move rel:0:20

      # increase window size
      shift + alt - a : /opt/homebrew/bin/yabai -m window --resize left:-20:0
      shift + alt - w : /opt/homebrew/bin/yabai -m window --resize top:0:-20

      # decrease window size
      shift + cmd - s : /opt/homebrew/bin/yabai -m window --resize bottom:0:-20
      shift + cmd - w : /opt/homebrew/bin/yabai -m window --resize top:0:20

      # set insertion point in focused container
      ctrl + lalt - n : /opt/homebrew/bin/yabai -m window --insert west
      ctrl + lalt - i : /opt/homebrew/bin/yabai -m window --insert south
      ctrl + lalt - o : /opt/homebrew/bin/yabai -m window --insert north
      ctrl + lalt - h : /opt/homebrew/bin/yabai -m window --insert east

      # toggle window zoom
      alt - d : /opt/homebrew/bin/yabai -m window --toggle zoom-parent
      alt - f : /opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      alt - e : /opt/homebrew/bin/yabai -m window --toggle split

      alt - t :  /opt/homebrew/bin/yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')

      ctrl - return : ${pkgs.wezterm}/bin/wezterm
      ctrl - q : open http://
      ctrl + shift - e : open ~
      alt - t : /opt/homebrew/bin/yabai -m space --layout $(/opt/homebrew/bin/yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')

      lalt - n : /opt/homebrew/bin/yabai -m window --focus west || /opt/homebrew/bin/yabai -m display --focus west
      lalt - i : /opt/homebrew/bin/yabai -m window --focus south || /opt/homebrew/bin/yabai -m display --focus south
      lalt - o : /opt/homebrew/bin/yabai -m window --focus north || /opt/homebrew/bin/yabai -m display --focus north
      lalt - h : /opt/homebrew/bin/yabai -m window --focus east || /opt/homebrew/bin/yabai -m display --focus east
      alt + shift - n : /opt/homebrew/bin/yabai -m window --swap west || $(/opt/homebrew/bin/yabai -m window --display west; /opt/homebrew/bin/yabai -m display --focus west)
      alt + shift - i : /opt/homebrew/bin/yabai -m window --swap south || $(/opt/homebrew/bin/yabai -m window --display south; /opt/homebrew/bin/yabai -m display --focus south)
      alt + shift - o : /opt/homebrew/bin/yabai -m window --swap north || $(/opt/homebrew/bin/yabai -m window --display north; /opt/homebrew/bin/yabai -m display --focus north)
      alt + shift - h : /opt/homebrew/bin/yabai -m window --swap east || $(/opt/homebrew/bin/yabai -m window --display east; /opt/homebrew/bin/yabai -m display --focus east)
      # alt + cmd - y : ~/.config/skhd/stack west 
      # alt + cmd - n : ~/.config/skhd/stack south
      # alt + cmd - i : ~/.config/skhd/stack north
      # alt + cmd - o : ~/.config/skhd/stack east

      alt + ctrl - e : /Applications/Neovide.app/Contents/MacOS/neovide --frame none --multigrid

      # ctrl - 1 : /opt/homebrew/bin/yabai -m space --focus 1 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 1"
      # ctrl - 2 : /opt/homebrew/bin/yabai -m space --focus 2 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 2"
      # ctrl - 3 : /opt/homebrew/bin/yabai -m space --focus 3 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 3"
      # ctrl - 4 : /opt/homebrew/bin/yabai -m space --focus 4 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 4"
      # ctrl - 5 : /opt/homebrew/bin/yabai -m space --focus 4 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 5"
      # ctrl - 6 : /opt/homebrew/bin/yabai -m space --focus 6 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 6"
      # ctrl - 7 : /opt/homebrew/bin/yabai -m space --focus 7 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 7"
      # ctrl - 8 : /opt/homebrew/bin/yabai -m space --focus 8 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 8"
      # ctrl - 9 : /opt/homebrew/bin/yabai -m space --focus 9 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 9"
      # ctrl - 0 : /opt/homebrew/bin/yabai -m space --focus 10 || /opt/homebrew/bin/skhd -k "ctrl + alt + cmd - 0"

      # Sonoma bandaid
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
