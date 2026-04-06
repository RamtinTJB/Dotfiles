---
name: obsidian-weekly-summary
description: create a weekly summary of the accomplishments and notes I've taken during the given week and any remaining action items
argument-hint: "[start-date] [end-date]"
disable-model-invocation: true
allowed-tools: Read, Bash(ls *)
---

summarize my readings, tasks, and the problems I have solved in the previous weeks by reading the daily notes I've taken from $0 to $1
- these files are located in /Users/rtjb/Obsidian/Notes/Daily Notes and are formatted as yyyy-mm-dd.md
- only read the notes from $0 to $1, fully disregard any other markdown file in this directory

the name of the summary file must be "weekly\_summary\_{start-date}\_{end-date}"
- keep the date formats as yyyy-mm-dd

IMPORTANT FORMATTING NOTE FOR THE SUMMARY
- I open the notes in Obsidian, and it renders all the extra new lines which makes the document look ugly. In the summary you are writing, only add a new line where it's absolutely necessary, e.g. between two regular text paragraphs. A new line after a header or before/after bullet points is not necessary. Pay close attention to this formatting rule when composing the summary file

1. the format of the summary must be markdown
2. the summary should be concise and to the point. I just want to spend around 30 minutes to reflect on my week and review some of the concepts
3. in the summary, create a table of all the readings for the week, their sources, and a couple of interesting/important notes from each. keep the notes very short. For each reading, if the daily note contains the link, include the link in the table (have the title act as the link)
4. in the summary, include some broad things I achieved during the week that are outlined in the "tasks" section in the daily notes. if two or more tasks can be coalesced into a broader task description, do that for the summary
5. in the summary, include a table of all the problems I've solved and the category that each problem corresponds to. keep the categories broad, such as linked-list, graph, dp, ...
6. at the end of the summary, include anything that I've marked in daily notes as "to be reviewed" or things that I mentioned are confusing or that I need to spend more time on later. create a checklist for these and keep them concise and to the point as well.

after creating the summary, move the notes for the specified week to the folder corresponding to its month. for instance, if you are summarizing notes from a week in March 2026, move the notes to the "March 2026 folder".
- create the folder if it doesn't exist yet
- move the summary you created to this folder as well
- if the days span two months, move each note to the appropriate folder and create the folder if it doesn't exist. in this case, the summary should be moved to the latter month's folder
