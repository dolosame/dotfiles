# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/.config/bash" ]; then
  for file in "$HOME/.config/bash"/*.bash; do
    [ -r "$file" ] && source "$file"
  done
  unset file
fi
