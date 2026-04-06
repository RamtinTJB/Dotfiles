---
name: gws-calendar-insert
description: "Google Calendar: Create a new event. Use this skill any time the user mentions adding an event to his calendar"
allowed-tools: Bash(gws calendar +insert *)
---

# calendar +insert

create a new event

## Usage

```bash
gws calendar +insert --summary <TEXT> --start <TIME> --end <TIME>
```

## Flags

| Flag | Required | Default | Description |
|------|----------|---------|-------------|
| `--calendar` | — | primary | Calendar ID (default: primary) |
| `--summary` | ✓ | — | Event summary/title |
| `--start` | ✓ | — | Start time (ISO 8601, e.g., 2024-01-01T10:00:00Z) |
| `--end` | ✓ | — | End time (ISO 8601) |
| `--location` | — | — | Event location |
| `--description` | — | — | Event description/body |
| `--attendee` | — | — | Attendee email (can be used multiple times) |
| `--meet` | — | — | Add a Google Meet video conference link |

## Examples

```bash
gws calendar +insert --summary 'Standup' --start '2026-06-17T09:00:00-07:00' --end '2026-06-17T09:30:00-07:00'
gws calendar +insert --summary 'Review' --start ... --end ... --attendee alice@example.com
gws calendar +insert --summary 'Meet' --start ... --end ... --meet
```

> [!IMPORTANT]
> Unless otherwise specified, use **PDT** (UTC-7) as the default time zone

## Title of the event

- The title has to concise and informative
- If there are other information that you think should be included in the event but would make the title too long, include them in the description of them event using `--description`
- If it's a one on one meeting, format it as `[other-person] <> Ramtin`. e.g. If I'm meeting with Jack, the title should be `Jack <> Ramtin`

## Tips

- Use RFC3339 format for times (e.g. 2026-06-17T09:00:00-07:00).
- The --meet flag automatically adds a Google Meet link to the event. Use this any time the user provides an email address
