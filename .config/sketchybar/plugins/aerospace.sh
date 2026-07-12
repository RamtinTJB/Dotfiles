#!/usr/bin/env bash

# Arg 1 = the workspace id this item represents.
# Highlights the focused workspace and shows glyphs for the apps living in it.
source "$CONFIG_DIR/colors.sh"

sid="$1"
ICON_MAP="$CONFIG_DIR/plugins/icon_map.sh"
FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null)"

# Build a deduped string of app glyphs for windows in this workspace
ICONS=""
if [ -f "$ICON_MAP" ]; then
  source "$ICON_MAP"
  APPS="$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null | sort -u)"
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    ICONS+="$icon_result"
  done <<< "$APPS"
fi

ARGS=(icon="$sid")
if [ -n "$ICONS" ]; then
  ARGS+=(label="$ICONS" label.drawing=on label.font="sketchybar-app-font:Regular:16.0")
else
  ARGS+=(label.drawing=off)
fi

if [ "$sid" = "$FOCUSED" ]; then
  ARGS+=(background.drawing=on background.color="$MAUVE" icon.color="$BASE" label.color="$BASE")
else
  ARGS+=(background.drawing=off icon.color="$SUBTEXT0" label.color="$TEXT")
fi

sketchybar --animate tanh 12 --set "$NAME" "${ARGS[@]}"
