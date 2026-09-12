#!/usr/bin/env bash

SELECTED=$(printf "Logout\nShutdown\nReboot\nSuspend" | fuzzel -d --only-match --hide-prompt --index --minimal-lines --width 10)

case "$SELECTED" in
  0)  loginctl terminate-session "$XDG_SESSION_ID"  ;;
  1)  loginctl poweroff ;;
  2)  loginctl reboot ;;
  3)  loginctl suspend  ;;
  *)  exit 1  ;;
esac
