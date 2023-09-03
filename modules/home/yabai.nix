{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
      /usr/local/bin/yabai -m config mouse_follows_focus          on
      /usr/local/bin/yabai -m config focus_follows_mouse          autoraise
      /usr/local/bin/yabai -m config window_origin_display        default
      /usr/local/bin/yabai -m config window_placement             second_child
      /usr/local/bin/yabai -m config window_topmost               off
      /usr/local/bin/yabai -m config window_shadow                off
      /usr/local/bin/yabai -m config window_opacity               off
      /usr/local/bin/yabai -m config window_opacity_duration      0.0
      /usr/local/bin/yabai -m config active_window_opacity        1.0
      /usr/local/bin/yabai -m config normal_window_opacity        0.90
      /usr/local/bin/yabai -m config window_border                on
      /usr/local/bin/yabai -m config window_border_width          4
      # /usr/local/bin/yabai -m config window_border_radius         10
      /usr/local/bin/yabai -m config active_window_border_color   0xff${config.colorScheme.colors.base09}
      /usr/local/bin/yabai -m config normal_window_border_color   0xff${config.colorScheme.colors.base00}
      /usr/local/bin/yabai -m config insert_feedback_color        0xff${config.colorScheme.colors.base05}
      /usr/local/bin/yabai -m config split_ratio                  0.50
      /usr/local/bin/yabai -m config auto_balance                 off
      /usr/local/bin/yabai -m config mouse_modifier               ctrl
      /usr/local/bin/yabai -m config mouse_action1                move
      /usr/local/bin/yabai -m config mouse_action2                resize
      /usr/local/bin/yabai -m config mouse_drop_action            swap
      /usr/local/bin/yabai -m config external_bar all:25:0

      # general space settings
      /usr/local/bin/yabai -m config layout                       bsp
      /usr/local/bin/yabai -m config top_padding                  18
      /usr/local/bin/yabai -m config bottom_padding               18
      /usr/local/bin/yabai -m config left_padding                 18
      /usr/local/bin/yabai -m config right_padding                18
      /usr/local/bin/yabai -m config window_gap                   18

      # system floating windows
      # /usr/local/bin/yabai -m rule --add app="^Finder$" manage=off
      /usr/local/bin/yabai -m rule --add app="^System Preferences$" manage=off
      /usr/local/bin/yabai -m rule --add title='Preferences$' manage=off
      /usr/local/bin/yabai -m rule --add title='Settings$' manage=off
      /usr/local/bin/yabai -m rule --add app="^System Information$" manage=off
      /usr/local/bin/yabai -m rule --add title="Software Update$" manage=off
      /usr/local/bin/yabai -m rule --add app="^App Store$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Disk Utility$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Activity Monitor$" manage=off
      /usr/local/bin/yabai -m rule --add title='Archive Utility$' manage=off
      /usr/local/bin/yabai -m rule --add title='Bin$' manage=off
      /usr/local/bin/yabai -m rule --add title="^Opening*" manage=off

      # 3rd party
      /usr/local/bin/yabai -m rule --add app="^Alfred Preferences$" manage=off
      /usr/local/bin/yabai -m rule --add app="UTM" manage=off
      /usr/local/bin/yabai -m rule --add app="^Stats$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Hidden Bar$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Amphetamine$" manage=off
      /usr/local/bin/yabai -m rule --add app="^zoom.us$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Docker Desktop$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Spaceman$" manage=off
      /usr/local/bin/yabai -m rule --add app="^Steam$" manage=off
      /usr/local/bin/yabai -m rule --add app="Photoshop" manage=off

      /usr/local/bin/yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      /usr/local/bin/yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      /usr/local/bin/yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      /usr/local/bin/yabai -m rule --add label="App Store" app="^App Store$" manage=off
      /usr/local/bin/yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      /usr/local/bin/yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      /usr/local/bin/yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      /usr/local/bin/yabai -m rule --add label="mpv" app="^mpv$" manage=off
      /usr/local/bin/yabai -m rule --add label="Software Update" title="Software Update" manage=off
      /usr/local/bin/yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off

      #/usr/local/bin/yabai -m config --space 2 layout float
      #/usr/local/bin/yabai -m config --space 2  focus_follows_mouse off

      /usr/local/bin/yabai -m config window_border_blur off

      # Broken for some reason
      # /usr/local/bin/yabai -m signal --add event=window_created action='/usr/local/bin/yabai -m query --windows --window $YABAI_WINDOW_ID | ${pkgs.jq} -er ".\"can-resize\" or .\"is-floating\"" || yabai -m window $YABAI_WINDOW_ID --toggle float'

      /usr/local/bin/yabai -m signal --add event=dock_did_restart action="sudo /usr/local/bin/yabai --load-sa"
      sudo /usr/local/bin/yabai --load-sa

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

      window=$(/usr/local/bin/yabai -m query --windows --window | jq -r '.id') 

      # Stack this window onto existing stack if possible
      /usr/local/bin/yabai -m window $dir --stack $window 
      if [[ $? -ne 0 ]]; then
      # otherwise, float and un-float this window to reinsert it into 
      # the bsp tree as a new window
      /usr/local/bin/yabai -m window --insert $dir
      /usr/local/bin/yabai -m window $window --toggle float 
      /usr/local/bin/yabai -m window $window --toggle float
      fi
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # balance size of windows
      shift + alt - 0 : /usr/local/bin/yabai -m space --balance

      # make floating window fill screen
      shift + alt - up     : /usr/local/bin/yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      shift + alt - left   : /usr/local/bin/yabai -m window --grid 1:2:0:0:1:1

      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)

      # fast focus desktop
      cmd + alt - x : /usr/local/bin/yabai -m space --focus recent
      cmd + alt - 1 : /usr/local/bin/yabai -m space --focus 1

      # send window to desktop and follow focus
      # shift + cmd - z : /usr/local/bin/yabai -m window --space next; /usr/local/bin/yabai -m space --focus next
      shift + cmd - 2 : /usr/local/bin/yabai -m window --space  2; /usr/local/bin/yabai -m space --focus 2

      # focus monitor
      ctrl + alt - z  : /usr/local/bin/yabai -m display --focus prev
      ctrl + alt - 3  : /usr/local/bin/yabai -m display --focus 3

      # send window to monitor and follow focus
      ctrl + cmd - c  : /usr/local/bin/yabai -m window --display next; /usr/local/bin/yabai -m display --focus next
      ctrl + cmd - 1  : /usr/local/bin/yabai -m window --display 1; /usr/local/bin/yabai -m display --focus 1

      # move floating window
      shift + ctrl - a : /usr/local/bin/yabai -m window --move rel:-20:0
      shift + ctrl - s : /usr/local/bin/yabai -m window --move rel:0:20

      # increase window size
      shift + alt - a : /usr/local/bin/yabai -m window --resize left:-20:0
      shift + alt - w : /usr/local/bin/yabai -m window --resize top:0:-20

      # decrease window size
      shift + cmd - s : /usr/local/bin/yabai -m window --resize bottom:0:-20
      shift + cmd - w : /usr/local/bin/yabai -m window --resize top:0:20

      # set insertion point in focused container
      ctrl + alt - y : /usr/local/bin/yabai -m window --insert west

      # toggle window zoom
      alt - d : /usr/local/bin/yabai -m window --toggle zoom-parent
      alt - f : /usr/local/bin/yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      alt - e : /usr/local/bin/yabai -m window --toggle split

      ctrl - return : wezterm
      ctrl - q : open http://
      ctrl + shift - e : open ~
      alt - t : /usr/local/bin/yabai -m space --layout $(/usr/local/bin/yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')

      alt - y : /usr/local/bin/yabai -m window --focus west || /usr/local/bin/yabai -m display --focus west
      alt - n : /usr/local/bin/yabai -m window --focus south || /usr/local/bin/yabai -m display --focus south
      alt - i : /usr/local/bin/yabai -m window --focus north || /usr/local/bin/yabai -m display --focus north
      alt - o : /usr/local/bin/yabai -m window --focus east || /usr/local/bin/yabai -m display --focus east
      alt + shift - y : /usr/local/bin/yabai -m window --swap west || $(/usr/local/bin/yabai -m window --display west; /usr/local/bin/yabai -m display --focus west)
      alt + shift - n : /usr/local/bin/yabai -m window --swap south || $(/usr/local/bin/yabai -m window --display south; /usr/local/bin/yabai -m display --focus south)
      alt + shift - i : /usr/local/bin/yabai -m window --swap north || $(/usr/local/bin/yabai -m window --display north; /usr/local/bin/yabai -m display --focus north)
      alt + shift - o : /usr/local/bin/yabai -m window --swap east || $(/usr/local/bin/yabai -m window --display east; /usr/local/bin/yabai -m display --focus east)
      alt + cmd - y : ~/.config/skhd/stack west 
      alt + cmd - n : ~/.config/skhd/stack south
      alt + cmd - i : ~/.config/skhd/stack north
      alt + cmd - o : ~/.config/skhd/stack east

      alt + ctrl - e : /Applications/Neovide.app/Contents/MacOS/neovide --frame none --multigrid
    '';
  };
}
