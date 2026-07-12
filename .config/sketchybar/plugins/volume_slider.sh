#!/usr/bin/env bash

# Dragging the slider sends the new value in $PERCENTAGE
if [ -n "$PERCENTAGE" ]; then
  osascript -e "set volume output volume $PERCENTAGE"
fi
