---
name: review-dirty
description: |
  Review uncommitted (dirty) code changes using Codex as an independent reviewer, then act on the findings.
  Trigger whenever the user asks to review dirty changes, review uncommitted work,
  get a code review on current changes, or says "review dirty". Also trigger when
  the user wants a second opinion on changes they've made before committing.
allowed-tools: Bash(codex exec *), Read, Edit, Glob, Grep
---

# Review Dirty Changes

Use Codex as an independent reviewer for uncommitted changes in the current repo,
then act on the findings. All dirty repo changes are likely made in this session,
though not always.

## Step 1: Run the review

Run this command via Bash with at least a 10-minute timeout:

```bash
codex exec \
  --sandbox read-only \
  --ephemeral \
  "Do not modify anything unless I tell you to. Assume all the verification steps has already been done prior to handing the review off to you, so don't waste time rerunning them (tests, lints, ...). Review the dirty changes which are to implement: <prompt>" \
  $ARGUMENTS 2>/dev/null
```

- `--sandbox read-only` — this is a review, nothing should be modified
- `--ephemeral` — one-off review, no need to persist the session
- `2>/dev/null` — suppress stderr noise
- Replace `<prompt>` with what the user says the changes implement
- `$ARGUMENTS` — pass through any extra context from the user

## Step 2: Present findings and your opinion

After Codex finishes, present every finding to the user along with your own
assessment. For each finding:

1. **Summarize it** — what Codex flagged, where, and what it suggests.
2. **Give your opinion** — do you agree it's a real issue? Is the suggested fix
   the right approach, or would you do it differently? If you disagree with
   Codex, explain why concretely. If you agree but would tweak the fix, say so.
3. **Ask the user** — let them accept, reject, or refine each finding before
   anything gets changed.

Do **not** edit any code during this step. The goal is to have a conversation
where you and the user align on exactly what should be fixed and how, before
a single line is touched.

## Step 3: Implement approved fixes

Once the user has reviewed all findings and told you which ones to act on
(and how), go ahead and implement only the approved changes. Use the codebase
tools (Read, Edit, Glob, Grep) to apply the fixes.

After you're done, give a brief summary of what was changed so the user can
verify.
