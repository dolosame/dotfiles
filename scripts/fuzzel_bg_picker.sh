#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures"
EXTENSIONS=(-name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp')

IMG=$(find "$WALL_DIR" -maxdepth 1 -type f \( "${EXTENSIONS[@]}" \) -printf "%P\n" | fuzzel -d --only-match)
[ -n "$IMG" ] || exit 0

OLD_PIDS=$(pgrep -x swaybg)

swaybg -i "$WALL_DIR/$IMG" -m fill &
notify-send -u low "Wallpaper" "Applied $IMG."

if [ -n "$OLD_PIDS" ]; then
  sleep 1
  kill $OLD_PIDS
fi
