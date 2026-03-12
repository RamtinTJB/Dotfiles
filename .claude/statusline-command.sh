#!/usr/bin/env bash
# Claude Code developer status line

input=$(cat)

# --- Extract fields from JSON input ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
session_id=$(echo "$input" | jq -r '.session_id // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# --- Usage tracking (daily / weekly) ---
USAGE_LOG="$HOME/.claude/usage-log.jsonl"
touch "$USAGE_LOG"
today=$(date +%Y-%m-%d)
# ISO week: year-Www  (e.g. 2026-W09)
week=$(date +%Y-W%V)

if [ -n "$session_id" ]; then
  session_tokens=$(( total_in + total_out ))
  # Update or append entry for this session
  tmp_log=$(mktemp)
  found=0
  while IFS= read -r line; do
    sid=$(echo "$line" | jq -r '.session_id // empty' 2>/dev/null)
    if [ "$sid" = "$session_id" ]; then
      echo "{\"session_id\":\"$session_id\",\"date\":\"$today\",\"week\":\"$week\",\"tokens\":$session_tokens}" >> "$tmp_log"
      found=1
    else
      echo "$line" >> "$tmp_log"
    fi
  done < "$USAGE_LOG"
  if [ "$found" -eq 0 ]; then
    echo "{\"session_id\":\"$session_id\",\"date\":\"$today\",\"week\":\"$week\",\"tokens\":$session_tokens}" >> "$tmp_log"
  fi
  mv "$tmp_log" "$USAGE_LOG"
fi

# Sum tokens for today and this week
daily_tokens=$(jq -r --arg d "$today" 'select(.date==$d) | .tokens' "$USAGE_LOG" 2>/dev/null | awk '{s+=$1} END{print s+0}')
weekly_tokens=$(jq -r --arg w "$week" 'select(.week==$w) | .tokens' "$USAGE_LOG" 2>/dev/null | awk '{s+=$1} END{print s+0}')

# Format token counts: show in K or M
format_tokens() {
  local t=$1
  if [ "$t" -ge 1000000 ]; then
    printf "%.1fM" "$(echo "scale=1; $t / 1000000" | bc)"
  elif [ "$t" -ge 1000 ]; then
    printf "%.0fK" "$(echo "scale=0; $t / 1000" | bc)"
  else
    printf "%d" "$t"
  fi
}

# --- Colors (ANSI, will appear dimmed in status bar) ---
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[36m'
YELLOW='\033[33m'
GREEN='\033[32m'
MAGENTA='\033[35m'
BLUE='\033[34m'
RED='\033[31m'
WHITE='\033[37m'

# --- Git info (skip optional locks to avoid blocking) ---
git_branch=""
git_status=""
if git -C "$cwd" rev-parse --is-inside-work-tree --no-optional-locks 2>/dev/null | grep -q true; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  # Check for uncommitted changes
  if ! git -C "$cwd" diff --quiet --no-optional-locks 2>/dev/null || \
     ! git -C "$cwd" diff --cached --quiet --no-optional-locks 2>/dev/null; then
    git_status="*"
  fi
  # Check for untracked files
  if [ -n "$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null)" ]; then
    git_status="${git_status}?"
  fi
fi

# --- Shorten paths (replace $HOME with ~) ---
home="$HOME"
short_cwd="${cwd/#$home/~}"
short_project="${project_dir/#$home/~}"

# --- Context usage bar ---
ctx_display=""
if [ -n "$used_pct" ]; then
  used_int=${used_pct%.*}
  if [ "$used_int" -ge 80 ]; then
    ctx_color="$RED"
  elif [ "$used_int" -ge 50 ]; then
    ctx_color="$YELLOW"
  else
    ctx_color="$GREEN"
  fi
  ctx_display="${ctx_color}ctx:${used_int}%${RESET}"
fi

# --- Build status line ---
parts=()

# Model
if [ -n "$model" ]; then
  parts+=("${MAGENTA}${model}${RESET}")
fi

# Agent (if running in agent mode)
if [ -n "$agent_name" ]; then
  parts+=("${YELLOW}agent:${agent_name}${RESET}")
fi

# Vim mode
if [ -n "$vim_mode" ]; then
  if [ "$vim_mode" = "NORMAL" ]; then
    parts+=("${BLUE}[NORMAL]${RESET}")
  else
    parts+=("${GREEN}[INSERT]${RESET}")
  fi
fi

# Project root (only show if different from cwd)
if [ -n "$short_project" ] && [ "$short_project" != "$short_cwd" ]; then
  parts+=("${DIM}proj:${RESET}${WHITE}${short_project}${RESET}")
fi

# Current working directory
if [ -n "$short_cwd" ]; then
  parts+=("${CYAN}${BOLD}${short_cwd}${RESET}")
fi

# Git branch
if [ -n "$git_branch" ]; then
  parts+=("${GREEN}git:${git_branch}${RED}${git_status}${RESET}")
fi

# Context usage
if [ -n "$ctx_display" ]; then
  parts+=("$ctx_display")
fi

# Daily / weekly token usage
if [ "${daily_tokens:-0}" -gt 0 ] || [ "${weekly_tokens:-0}" -gt 0 ]; then
  daily_fmt=$(format_tokens "${daily_tokens:-0}")
  weekly_fmt=$(format_tokens "${weekly_tokens:-0}")
  parts+=("${DIM}day:${RESET}${WHITE}${daily_fmt}${RESET}${DIM} wk:${RESET}${WHITE}${weekly_fmt}${RESET}")
fi

# --- Join parts with separator ---
sep="${DIM} | ${RESET}"
line=""
for part in "${parts[@]}"; do
  if [ -z "$line" ]; then
    line="$part"
  else
    line="${line}${sep}${part}"
  fi
done

printf "%b\n" "$line"
