{ colorScheme, font, ... }:
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
                          padding_left=5 \
                          padding_right=5 \
                          margin=0 \
                          corner_radius=0 \
                          color=0x7f${colorScheme.colors.base00} \
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
                              icon.padding_left=6 \
                              icon.padding_right=6

      ############## PRIMARY DISPLAY SPACES ##############
      sketchybar -m --add space productivity left \
                    --set productivity associated_space=1 \
                               associated_display=1 \
                               icon=1 \
                               click_script="yabai -m space --focus 1" \
                               background.color=0x7f${colorScheme.colors.base00} \
                               background.drawing=off \
                    --subscribe productivity mouse.entered mouse.exited \
                                                                       \
                    --add space browser left \
                    --set browser associated_display=1 \
                               associated_space=2 \
                               icon=2 \
                               click_script="yabai -m space --focus 2" \
                               background.color=0x7f${colorScheme.colors.base00} \
                               background.drawing=off \
                    --subscribe browser mouse.entered mouse.exited \
                                                                       \
                    --add space messaging left \
                    --set messaging associated_display=1 \
                               associated_space=3 \
                               icon=3 \
                               click_script="yabai -m space --focus 3" \
                               background.color=0x7f${colorScheme.colors.base00} \
                               background.drawing=off \
                    --subscribe messaging mouse.entered mouse.exited

      ############## ITEM DEFAULTS ###############
      sketchybar -m --default label.padding_left=0 \
                              icon.padding_right=3 \
                              icon.padding_left=6 \
                              label.padding_right=3

      ############## RIGHT ITEMS ##############

      sketchybar -m --add item clock right \
                    --set clock update_freq=1 \
                                script="~/.config/sketchybar/plugins/clock.sh" \
                                background.color=0x00${colorScheme.colors.base00} \
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
}
