---
name: commit-succinct
description: Commit code succinctly
disable-model-invocation: true
allowed-tools: Bash(git status) Bash(git diff *) Bash(git log *) Bash(git commit -m *) Bash(git add *)
---

commit the dirty changes with a short, succinct message. assume you are currently in the git repository and do not use the `-C` arguemnt when running git
