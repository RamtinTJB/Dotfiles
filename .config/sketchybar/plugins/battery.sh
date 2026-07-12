#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

BATT="$(pmset -g batt)"
PERCENTAGE="$(echo "$BATT" | grep -Eo '[0-9]+%' | head -1 | cut -d% -f1)"
CHARGING="$(echo "$BATT" | grep 'AC Power')"

[ -z "$PERCENTAGE" ] && exit 0

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="" ;;
  [6-8][0-9]) ICON="" ;;
  [3-5][0-9]) ICON="" ;;
  [1-2][0-9]) ICON="" ;;
  *)          ICON="" ;;
esac
[ -n "$CHARGING" ] && ICON=""

# Color by level: normal text, yellow 10-30, red below 10
if [ "$PERCENTAGE" -lt 10 ]; then
  COLOR="$RED"
elif [ "$PERCENTAGE" -le 30 ]; then
  COLOR="$YELLOW"
else
  COLOR="$TEXT"
fi

# Popup detail: charge state + time estimate
TIME="$(echo "$BATT" | grep -Eo '[0-9]+:[0-9]+' | head -1)"
if [ -n "$CHARGING" ]; then
  DETAIL="Charging"
else
  DETAIL="On battery"
fi
[ -n "$TIME" ] && DETAIL="$DETAIL · $TIME remaining"

sketchybar --animate sin 10 \
           --set "$NAME" icon="$ICON" icon.color="$COLOR" \
                         label="${PERCENTAGE}%" label.color="$COLOR" \
           --set battery.details label="$DETAIL"
