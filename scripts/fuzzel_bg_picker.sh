#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures"
EXTENSIONS=(-name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp')

SELECTED=$(find "$WALL_DIR" -maxdepth 1 -type f \( "${EXTENSIONS[@]}" \) -printf "%P\n" | fuzzel -d --only-match)
[ -n "$SELECTED" ] || exit 1

OLD_PIDS=$(pgrep -x swaybg)

swaybg -i "$WALL_DIR/$SELECTED" -m fill &
notify-send -u low "Wallpaper" "Applied $SELECTED"

if [ -n "$OLD_PIDS" ]; then
  sleep 1
  kill $OLD_PIDS
fi
