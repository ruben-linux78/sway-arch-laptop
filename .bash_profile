# System settings before starting X
. $HOME/.bashrc

[ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec dbus-run-session sway




