#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures"
cd "$WALL_DIR" || exit 1

shopt -s nullglob
FILES=( *.{png,jpg,jpeg,webp} )

PS3=$'\nSelect a number for your wallpaper: '

select IMG in "${FILES[@]}"; do
    if [[ -n "$IMG" ]]; then

        setsid swaybg -m fill -i "$WALL_DIR/$IMG" > /dev/null 2>&1 &
        pgrep -x swaybg | grep -v "$!" | xargs -r kill

        notify-send -u low "Wallpaper" "Applied ${IMG%.*}"
        break
    else
        printf '\033[2A\033[J'
        PS3=$'\nInvalid choice. Select a number: '
    fi
done
