{ config, pkgs, lib, ... }:
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      /opt/homebrew/bin/yabai -m config mouse_follows_focus on
      /opt/homebrew/bin/yabai -m config focus_follows_mouse autoraise
      /opt/homebrew/bin/yabai -m config window_origin_display default
      /opt/homebrew/bin/yabai -m config window_placement second_child
      /opt/homebrew/bin/yabai -m config window_shadow off
      /opt/homebrew/bin/yabai -m config window_opacity off
      /opt/homebrew/bin/yabai -m config window_opacity_duration 0.0
      /opt/homebrew/bin/yabai -m config active_window_opacity 1.0
      /opt/homebrew/bin/yabai -m config normal_window_opacity 0.90
      /opt/homebrew/bin/yabai -m config split_ratio 0.50
      /opt/homebrew/bin/yabai -m config auto_balance off
      /opt/homebrew/bin/yabai -m config layout bsp
      /opt/homebrew/bin/yabai -m config top_padding 18
      /opt/homebrew/bin/yabai -m config bottom_padding 18
      /opt/homebrew/bin/yabai -m config left_padding 18
      /opt/homebrew/bin/yabai -m config right_padding 18
      /opt/homebrew/bin/yabai -m config window_gap 18
      /opt/homebrew/bin/yabai -m config mouse_modifier ctrl
      /opt/homebrew/bin/yabai -m config mouse_action1 move
      /opt/homebrew/bin/yabai -m config mouse_action2 resize
      /opt/homebrew/bin/yabai -m config mouse_drop_action swap
      /opt/homebrew/bin/yabai -m config external_bar off:0:0
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
      /opt/homebrew/bin/yabai -m signal --add event=dock_did_restart action="sudo /opt/homebrew/bin/yabai --load-sa"
      sudo /opt/homebrew/bin/yabai --load-sa

      echo "yabai configuration loaded..."
    '';
  };
}