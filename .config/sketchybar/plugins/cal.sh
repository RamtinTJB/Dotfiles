#!/usr/bin/env bash

ICON=""

if ! command -v icalBuddy >/dev/null 2>&1; then
  sketchybar --set "$NAME" icon="$ICON" label="no icalBuddy"
  exit 0
fi

# Next event today: "HH:MM Title"
NEXT="$(icalBuddy -n -nc -nrd -ea -b "" -ps "| |" -iep "datetime,title" \
        -po "datetime,title" -df "" -tf "%H:%M" -li 1 eventsToday 2>/dev/null \
        | head -1 \
        | sed -E 's/ - [0-9]{1,2}:[0-9]{2}//' \
        | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

if [ -z "$NEXT" ]; then
  sketchybar --set "$NAME" icon="$ICON" label="No events"
else
  # Trim very long titles
  if [ "${#NEXT}" -gt 32 ]; then
    NEXT="${NEXT:0:31}…"
  fi
  sketchybar --set "$NAME" icon="$ICON" label="$NEXT"
fi
