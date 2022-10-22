{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
      yabai -m config mouse_follows_focus          off
      yabai -m config focus_follows_mouse          off
      yabai -m config window_origin_display        default
      yabai -m config window_placement             second_child
      yabai -m config window_topmost               off
      yabai -m config window_shadow                on
      yabai -m config window_opacity               off
      yabai -m config window_opacity_duration      0.0
      yabai -m config active_window_opacity        1.0
      yabai -m config normal_window_opacity        0.90
      yabai -m config window_border                on
      yabai -m config window_border_width          6
      yabai -m config active_window_border_color   0xFF3b2a7b
      yabai -m config normal_window_border_color   0x006453a3
      yabai -m config insert_feedback_color        0xffd75f5f
      yabai -m config split_ratio                  0.50
      yabai -m config auto_balance                 off
      yabai -m config mouse_modifier               ctrl
      yabai -m config mouse_action1                move
      yabai -m config mouse_action2                resize
      yabai -m config mouse_drop_action            swap

      # general space settings
      yabai -m config layout                       bsp
      yabai -m config top_padding                  32
      yabai -m config bottom_padding               32
      yabai -m config left_padding                 32
      yabai -m config right_padding                32
      yabai -m config window_gap                   32

      # system floating windows
      # yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add title='Preferences$' manage=off topmost=on
      yabai -m rule --add title='Settings$' manage=off
      yabai -m rule --add app="^System Information$" manage=off
      yabai -m rule --add title="Software Update$" manage=off
      yabai -m rule --add app="^App Store$" manage=off
      yabai -m rule --add app="^Disk Utility$" manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off
      yabai -m rule --add title='Archive Utility$' manage=off
      yabai -m rule --add title='Bin$' manage=off
      yabai -m rule --add title="^Opening*" manage=off

      # 3rd party
      yabai -m rule --add app="^Alfred Preferences$" manage=off
      yabai -m rule --add app="UTM" manage=off
      yabai -m rule --add app="^Stats$" manage=off
      yabai -m rule --add app="^Hidden Bar$" manage=off
      yabai -m rule --add app="^Amphetamine$" manage=off
      yabai -m rule --add app="^zoom.us$" manage=off
      yabai -m rule --add app="^Docker Desktop$" manage=off
      yabai -m rule --add app="^Spaceman$" manage=off
      yabai -m rule --add app="^Steam$" manage=off
      yabai -m rule --add app="Photoshop" manage=off
      yabai -m rule --add app="Plover" topmost=on

      #yabai -m config --space 2 layout float
      #yabai -m config --space 2  focus_follows_mouse off

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # focus window
      alt - h : yabai -m window --focus west

      # swap managed window
      shift + alt - h : yabai -m window --swap north

      # move managed window
      shift + cmd - h : yabai -m window --warp east

      # balance size of windows
      shift + alt - 0 : yabai -m space --balance

      # make floating window fill screen
      shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)

      # fast focus desktop
      cmd + alt - x : yabai -m space --focus recent
      cmd + alt - 1 : yabai -m space --focus 1

      # send window to desktop and follow focus
      # shift + cmd - z : yabai -m window --space next; yabai -m space --focus next
      shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2

      # focus monitor
      ctrl + alt - z  : yabai -m display --focus prev
      ctrl + alt - 3  : yabai -m display --focus 3

      # send window to monitor and follow focus
      ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
      ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1

      # move floating window
      shift + ctrl - a : yabai -m window --move rel:-20:0
      shift + ctrl - s : yabai -m window --move rel:0:20

      # increase window size
      shift + alt - a : yabai -m window --resize left:-20:0
      shift + alt - w : yabai -m window --resize top:0:-20

      # decrease window size
      shift + cmd - s : yabai -m window --resize bottom:0:-20
      shift + cmd - w : yabai -m window --resize top:0:20

      # set insertion point in focused container
      ctrl + alt - h : yabai -m window --insert west

      # toggle window zoom
      alt - d : yabai -m window --toggle zoom-parent
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky(+float), topmost, picture-in-picture
      alt - p : yabai -m window --toggle sticky;\
                yabai -m window --toggle topmost;\
                yabai -m window --toggle pip
      ctrl - return : /Applications/kitty.app/Contents/MacOS/kitty --single-instance -d ~
      ctrl - q : /Applications/Firefox.app/Contents/MacOS/firefox
      # ctrl - e : open ~
      alt - t : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')
    '';
  };
}
