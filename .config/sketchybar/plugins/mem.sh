#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

# Used memory percentage = 100 - free percentage (from memory_pressure)
FREE="$(memory_pressure 2>/dev/null | grep -Eo 'free percentage: [0-9]+' | grep -Eo '[0-9]+')"
[ -z "$FREE" ] && exit 0
USED=$((100 - FREE))

if [ "$USED" -ge 85 ]; then
  COLOR="$RED"
elif [ "$USED" -ge 65 ]; then
  COLOR="$YELLOW"
else
  COLOR="$PEACH"
fi

sketchybar --set "$NAME" icon="" label="${USED}%" label.color="$COLOR" icon.color="$COLOR"
