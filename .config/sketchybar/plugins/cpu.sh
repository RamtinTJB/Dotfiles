#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

# Two samples so the reading reflects current load, not since-boot average
LINE="$(top -l 2 -n 0 | grep -E '^CPU usage' | tail -1)"
USER="$(echo "$LINE" | awk '{print $3}' | tr -d '%')"
SYS="$(echo "$LINE" | awk '{print $5}' | tr -d '%')"
TOTAL="$(echo "$USER + $SYS" | bc 2>/dev/null)"
[ -z "$TOTAL" ] && exit 0

INT="${TOTAL%.*}"
PUSH="$(echo "scale=2; $TOTAL/100" | bc 2>/dev/null)"

# Color the graph/icon by load
if [ "$INT" -ge 80 ]; then
  COLOR="$RED"
elif [ "$INT" -ge 50 ]; then
  COLOR="$YELLOW"
else
  COLOR="$GREEN"
fi

sketchybar --push "$NAME" "$PUSH" \
           --animate sin 10 \
           --set "$NAME" graph.color="$COLOR" \
                         icon.color="$COLOR" \
                         label="${INT}%"
