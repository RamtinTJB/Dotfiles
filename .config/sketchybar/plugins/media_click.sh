#!/usr/bin/env bash

# Toggle play/pause on whichever supported player is active.
if pgrep -xq Spotify; then
  STATE="$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)"
  if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
    osascript -e 'tell application "Spotify" to playpause' 2>/dev/null
    sketchybar --update
    exit 0
  fi
fi

if pgrep -xq Music; then
  osascript -e 'tell application "Music" to playpause' 2>/dev/null
  sketchybar --update
fi
