#!/usr/bin/env bash

# Reads now-playing from Spotify, then Apple Music (whichever is active).
# No private frameworks — uses AppleScript, reliable on current macOS.

APP=""
STATE=""
ARTIST=""
TRACK=""

if pgrep -xq Spotify; then
  STATE="$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)"
  if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
    APP="Spotify"
    ARTIST="$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)"
    TRACK="$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)"
  fi
fi

if [ -z "$APP" ] && pgrep -xq Music; then
  STATE="$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)"
  if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
    APP="Music"
    ARTIST="$(osascript -e 'tell application "Music" to artist of current track' 2>/dev/null)"
    TRACK="$(osascript -e 'tell application "Music" to name of current track' 2>/dev/null)"
  fi
fi

if [ -z "$TRACK" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$STATE" = "playing" ]; then
  ICON=""        # pause glyph (click to pause)
else
  ICON=""        # play glyph (click to resume)
fi

LABEL="$TRACK"
[ -n "$ARTIST" ] && LABEL="$TRACK — $ARTIST"

sketchybar --set "$NAME" drawing=on icon="$ICON" label="$LABEL"
