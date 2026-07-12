#!/usr/bin/env bash

# Four time zones: Los Angeles, New York, Tehran, Queensland (Brisbane)
LA="$(TZ='America/Los_Angeles' date '+%H:%M')"
NY="$(TZ='America/New_York'     date '+%m/%d %H:%M')"
THR="$(TZ='Asia/Tehran'         date '+%H:%M')"
QLD="$(TZ='Australia/Brisbane'  date '+%H:%M')"

sketchybar --set "$NAME" label="NY $NY  LA $LA  THR $THR  QLD $QLD"
