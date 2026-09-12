if [[ "$TERM" != "linux" ]]; then

  if (( RANDOM % 100 < 50 )); then
    mini_fetch="$HOME/.config/scripts/mini_fetch.sh"
    [[ -x "$mini_fetch" ]] && "$mini_fetch"
  fi

  if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
  fi

fi
