#!/usr/bin/env bash

PICKED=$(printf "Lock\nLogout\nShutdown\nReboot\nSuspend" | fuzzel -d --only-match --hide-prompt --minimal-lines --width 10)

case "$PICKED" in
  Lock)     swaylock -f & ;;
  Logout)   loginctl terminate-session "$XDG_SESSION_ID" ;;
  Shutdown) loginctl poweroff ;;
  Reboot)   loginctl reboot ;;
  Suspend)  loginctl suspend ;;
  *)        exit 0 ;;
esac
