{ colorScheme, font, pkgs, ... }:
{
  home.file.sketchybar = {
    executable = true;
    target = ".config/sketchybar/sketchybarrc";
    text = ''
      #                          ﱦ 齃     ﮂ  ﵁ 爵        ﭵ     ﱦ  ﰊ 異 ﴱ אַ  'Y⃣'

      ############## BAR ##############
      sketchybar -m --bar height=25 \
                          blur_radius=0 \
                          position=top \
                          padding_left=0 \
                          padding_right=5 \
                          margin=0 \
                          corner_radius=0 \
                          color=0x7f${colorScheme.palette.base00} \
                          border_width=0 \
                          border_color=0xff2E3440

      ############## GLOBAL DEFAULTS ##############
      sketchybar -m --default updates=when_shown \
                              drawing=on \
                              cache_scripts=on \
                              icon.font="${font}:Regular:14.0" \
                              icon.color=0xffECEFF4 \
                              icon.highlight_color=0xffA3BE8C \
                              label.font="${font}:Regular:14.0" \
                              label.color=0xffECEFF4

      ############## SPACE DEFAULTS ##############
      sketchybar -m --default label.padding_left=0 \
                              label.padding_right=0 \
                              icon.padding_left=5 \
                              icon.padding_right=5

      ############## PRIMARY DISPLAY SPACES ##############
      SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

      spaces=()
      for i in "''${!SPACE_ICONS[@]}"
      do
        sid=$(($i+1))
        spaces+=(space.$sid)
        sketchybar --add space space.$sid left                                 \
                   --set space.$sid associated_space=$sid                      \
                                    icon=''${SPACE_ICONS[i]}                     \
                                    background.corner_radius=0                 \
                                    background.height=25                       \
                                    background.color=0xff${colorScheme.palette.base0A} \
                                    background.drawing=on                     \
                                    label.drawing=off                          \
                                    script="~/.config/sketchybar/plugins/space.sh"              \
                                    click_script="yabai -m space --focus $sid"
      done



      ############## ITEM DEFAULTS ###############
      sketchybar -m --default label.padding_left=0 \
                              icon.padding_right=0 \
                              icon.padding_left=0 \
                              label.padding_right=0

      ############## RIGHT ITEMS ##############

      sketchybar -m --add item clock right \
                    --set clock update_freq=1 \
                                script="~/.config/sketchybar/plugins/clock.sh" \
                                background.color=0x00${colorScheme.palette.base00} \
                                background.height=20 \
                                border_width=12 \
                                border_color=0xff2E3440

      sketchybar -m --add event song_update com.apple.iTunes.playerInfo
      sketchybar -m --add item music_info left \
                    --set music_info script="~/.config/sketchybar/plugins/music.sh" \
                                     click_script="~/.config/sketchybar/plugins/music_click.sh" \
                    --subscribe music_info song_update

      ############## FINALIZING THE SETUP ##############
      sketchybar -m --update

      echo "sketchybar configuration loaded..."
    '';
  };
  home.file.sketchybarClock = {
    executable = true;
    target = ".config/sketchybar/plugins/clock.sh";
    text = ''
      #!/bin/bash
      sketchybar --set $NAME label="$(date +"%H:%M")"
      '';
  };
  home.file.sketchybarSpace = {
    executable = true;
    target = ".config/sketchybar/plugins/space.sh";
    text = ''
    #!/usr/bin/env sh
    WIN=$(/opt/homebrew/bin/yabai -m query --spaces --space $SID | ${pkgs.jq}/bin/jq '.windows[0]')
    HAS_WINDOWS_OR_IS_SELECTED="true"
    if [ "$WIN" = "null" ] && [ "$SELECTED" = "false" ];then
      HAS_WINDOWS_OR_IS_SELECTED="false"
    fi
    if [ "$SELECTED" = "true" ];then
      sketchybar --set $NAME background.color=0xff${colorScheme.palette.base08} icon.drawing=$HAS_WINDOWS_OR_IS_SELECTED
    else
      sketchybar --set $NAME background.color=0xff${colorScheme.palette.base00} icon.drawing=$HAS_WINDOWS_OR_IS_SELECTED
    fi
    '';
  };
}
