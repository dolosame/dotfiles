#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures"
EXTENSIONS=(-name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp')

SELECTED=$(find "$WALL_DIR" -maxdepth 1 -type f \( "${EXTENSIONS[@]}" \) -printf "%P\n" | fuzzel -d)
[[ -z "$SELECTED" ]] && exit 0

OLD_PIDS=$(pgrep -f "swaybg")

swaybg -i "$WALL_DIR/$SELECTED" -m fill &
notify-send -u low "Wallpaper" "Applied $SELECTED"

sleep 1
if [[ -n "$OLD_PIDS" ]]; then
  kill $OLD_PIDS 2>/dev/null
fi
