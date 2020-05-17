#!/bin/bash

main() {
  if ! pgrep -x spotify >/dev/null; then
    echo ""
    exit
  fi

  cmd="org.freedesktop.DBus.Properties.Get"
  domain="org.mpris.MediaPlayer2"
  path="/org/mpris/MediaPlayer2"

  meta=$(dbus-send --print-reply --dest=${domain}.spotify \
    /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:${domain}.Player string:Metadata)

  ttype=$(echo "$meta" | sed -nr '/mpris:trackid"/,+2s/^ +variant +string "[^:]*:(.*):.*"$/\1/p')

  if [ "$ttype" = "ad" ]; then
      if [ $(pactl list sinks | sed -n 's/.*Mute:\s*//p' | tail -n 1) = "no" ]; then
          echo "TRUE" > /tmp/spotify_mute
          pactl set-sink-mute @DEFAULT_SINK@ 1
          echo "MUTING AN AD ;)"
      fi
  else
      if [ -f "/tmp/spotify_mute" ] ; then
          if [ $(cat /tmp/spotify_mute) = "TRUE" ]; then
              echo "FALSE" > /tmp/spotify_mute
              pactl set-sink-mute @DEFAULT_SINK@ 0
          fi
      fi

      # Normal track
      artist=$(echo "$meta" | sed -nr '/xesam:artist"/,+2s/^ +string "(.*)"$/\1/p' | tail -1  | sed 's/\&/\\&/g' | sed 's#\/#\\/#g')
      album=$(echo "$meta" | sed -nr '/xesam:album"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1| sed 's/\&/\\&/g'| sed 's#\/#\\/#g')
      title=$(echo "$meta" | sed -nr '/xesam:title"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1 | sed 's/\&/\\&/g'| sed 's#\/#\\/#g')

      echo "${*:-%artist% - %title%}" | sed "s/%artist%/$artist/g;s/%title%/$title/g;s/%album%/$album/g"i | sed "s/\&/\&/g" | sed "s#\/#\/#g"
  fi
}

main "$@"
