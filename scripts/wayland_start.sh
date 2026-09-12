#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures"
EXTENSIONS=(-name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp')
IMG=$(find "$WALL_DIR" -maxdepth 1 -type f \( "${EXTENSIONS[@]}" \) | shuf -n 1)
if [[ -z "$IMG" ]]; then
  notify-send -u low \
    "Script Error" \
    "No images found in $WALL_DIR"
fi

swaybg -i "$IMG" -m fill &

swayidle -w \
  timeout 480 "swaylock -f -i $IMG" \
  timeout 900 "niri msg action power-off-monitors" \
  timeout 1500 "loginctl suspend" \
  before-sleep "swaylock -f -i $IMG" &

pipewire &

while ! pw-cli info > /dev/null 2>&1; do
    sleep 0.1
done

i3bar-river &
