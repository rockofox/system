{ colorScheme, font, pkgs, ... }:
{
  home.file.sketchybar = {
    executable = true;
    target = ".config/sketchybar/sketchybarrc";
    text = ''
      #                          ﱦ 齃     ﮂ  ﵁ 爵        ﭵ     ﱦ  ﰊ 異 ﴱ אַ  'Y⃣'

      ############## BAR ##############
      sketchybar -m --bar height=25 \
                          position=top \
                          padding_left=0 \
                          padding_right=5 \
                          margin=0 \
                          corner_radius=0 \
                          color=0x7f${colorScheme.palette.base00} \
                          border_width=0 \
                          border_color=0xff2E3440 \
                          display=main \
                          blur_radius=4


      ############## GLOBAL DEFAULTS ##############
      sketchybar -m --default updates=when_shown \
                              drawing=on \
                              cache_scripts=on \
                              icon.font="${font}:Bold:14.0" \
                              icon.color=0xffECEFF4 \
                              icon.highlight_color=0xffA3BE8C \
                              label.font="${font}:Bold:14.0" \
                              label.color=0xffECEFF4 \
                              blur_radius=4

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
                                    background.color=0x7f${colorScheme.palette.base02} \
                                    background.drawing=on                     \
                                    label.drawing=off                          \
                                    script="~/.config/sketchybar/plugins/space.sh"              \
                                    click_script="yabai -m space --focus $sid"
      done



      ############## ITEM DEFAULTS ###############
      sketchybar -m --default label.padding_left=0 \
                              icon.padding_right=8 \
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

      # Add event
      sketchybar -m --add event song_update com.apple.iTunes.playerInfo

      # Add Music Item
      sketchybar -m --add item music right                         \
          --set music script="~/.config/sketchybar/plugins/music.sh"  \
          click_script="~/.config/sketchybar/plugins/music_click.sh"  \
          label.padding_right=20                                   \
          drawing=off                                              \
          --subscribe music media_change
          # label.max_chars=20 \
          # scroll_texts=on \


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
        sketchybar --set $NAME background.color=0xff${colorScheme.palette.base02} icon.drawing=$HAS_WINDOWS_OR_IS_SELECTED
      else
        sketchybar --set $NAME background.color=0x7f${colorScheme.palette.base00} icon.drawing=$HAS_WINDOWS_OR_IS_SELECTED
      fi
    '';
  };
  home.file.sketchybarMusic = {
    executable = true;
    target = ".config/sketchybar/plugins/music.sh";
    text = ''
      #!/usr/bin/env bash

      # FIXME: Running an osascript on an application target opens that app
      # This sleep is needed to try and ensure that theres enough time to
      # quit the app before the next osascript command is called. I assume 
      # com.apple.iTunes.playerInfo fires off an event when the player quits
      # so it imediately runs before the process is killed
      sleep 1

      APP_STATE=$(pgrep -x Music)
      if [[ ! $APP_STATE ]]; then 
          sketchybar -m --set music drawing=off
          exit 0
      fi

      PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
      if [[ $PLAYER_STATE == "stopped" ]]; then
          sketchybar --set music drawing=off
          exit 0
      fi

      title=$(osascript -e 'tell application "Music" to get name of current track')
      artist=$(osascript -e 'tell application "Music" to get artist of current track')
      # ALBUM=$(osascript -e 'tell application "Music" to get album of current track')
      loved=$(osascript -l JavaScript -e "Application('Music').currentTrack().loved()")
      if [[ $loved ]]; then
          icon="􀊸"
      fi

      if [[ $PLAYER_STATE == "paused" ]]; then
          icon="􀊘"
      fi

      if [[ $PLAYER_STATE == "playing" ]]; then
          icon="􀊖"
      fi

      if [[ ''${#title} -gt 25 ]]; then
      TITLE=$(printf "$(echo $title | cut -c 1-25)…")
      fi

      if [[ ''${#artist} -gt 25 ]]; then
      ARTIST=$(printf "$(echo $artist | cut -c 1-25)…")
      fi

      # if [[ ''${#ALBUM} -gt 25 ]]; then
      #   ALBUM=$(printf "$(echo $ALBUM | cut -c 1-12)…")
      # fi

      sketchybar -m --set music         \
          --set music icon="$icon" \
          --set music label="''${title} – ''${artist}"    \
          --set music drawing=on
          # --set music label.max_chars=20
          # --set music scroll_texts=on

    '';
  };
  home.file.musicClick = {
    executable = true;
    target = ".config/sketchybar/plugins/music_click.sh";
    text = ''
        #!/usr/bin/env bash

        # run an osascript command to get the player_state
        PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")

        # Check the PLAYER_STATE
        # If playing
        if [[ $PLAYER_STATE == "paused" ]]; then
          osascript -e 'tell application "Music" to play'
              else
          osascript -e 'tell application "Music" to pause'
        fi
    '';
  };
}
