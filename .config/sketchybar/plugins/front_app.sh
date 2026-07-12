#!/usr/bin/env bash

# Shows the focused app's name plus its glyph (if sketchybar-app-font is present)
ICON_MAP="$CONFIG_DIR/plugins/icon_map.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  if [ -f "$ICON_MAP" ]; then
    source "$ICON_MAP"
    __icon_map "$INFO"
    sketchybar --set "$NAME" icon="$icon_result" icon.drawing=on label="$INFO"
  else
    sketchybar --set "$NAME" label="$INFO"
  fi
fi
