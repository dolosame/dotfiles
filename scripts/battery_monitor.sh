#!/usr/bin/env bash

THRESHOLD_WARN=30; THRESHOLD_LOW=20; THRESHOLD_CRIT=10
LAST_NOTIFIED=100; INTERVAL=120

BAT_PATH=$(find /sys/class/power_supply/BAT*)

while true; do
  if [ -n "$BAT_PATH" ]; then

    STATUS=$(cat "$BAT_PATH/status")
    CAPACITY=$(cat "$BAT_PATH/capacity")
    if [ "$STATUS" = "Discharging" ]; then

      if [ "$CAPACITY" -le "$THRESHOLD_CRIT" ] && [ "$LAST_NOTIFIED" -gt "$THRESHOLD_CRIT" ]; then
        LAST_NOTIFIED=$CAPACITY
        notify-send -u critical \
                    "Battery Crit" \
                    "Battery level is at ${CAPACITY}%. Give me the goddam charger."
      fi

      if [ "$CAPACITY" -le "$THRESHOLD_LOW" ] && [ "$LAST_NOTIFIED" -gt "$THRESHOLD_LOW" ]; then
        LAST_NOTIFIED=$CAPACITY
        notify-send -u normal \
                    "Battery Low" \
                    "Battery level is at ${CAPACITY}%. Find me a charger."
      fi

      if [ "$CAPACITY" -le "$THRESHOLD_WARN" ] && [ "$LAST_NOTIFIED" -gt "$THRESHOLD_WARN" ]; then
        LAST_NOTIFIED=$CAPACITY
        notify-send -u normal \
                    "Battery Low" \
                    "Battery level is at ${CAPACITY}%. Remember to plug in the charger."
      fi

    else
      LAST_NOTIFIED=$CAPACITY
    fi

  fi

  sleep $INTERVAL
done
