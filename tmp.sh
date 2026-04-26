tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

env -i \
  HOME="$tmp" \
  XDG_CONFIG_HOME="$tmp/.config" \
  XDG_CACHE_HOME="$tmp/.cache" \
  XDG_DATA_HOME="$tmp/.local/share" \
  PATH="$PATH" \
  DISPLAY="$DISPLAY" \
  WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
  XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
  DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
  nix run github:zhom/donutbrowser#release-start

nix-collect-garbage -d