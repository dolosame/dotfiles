# .bash_profile

# Get the aliases and functions
[ -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

# Run window compositor without login manager
if [ "$(tty)" = "/dev/tty1" ]; then
  clear
  exec dbus-run-session -- niri --session > /tmp/niri.log 2>&1
fi
