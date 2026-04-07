# Dotfiles

Personal configuration for vim, tmux, and Claude Code.

## What's here

- `.vimrc` — Vim editor config
- `.tmux.conf` — Tmux terminal multiplexer config
- `.claude/` — Claude Code settings and custom skills
- `dotfiles_setup.sh` — Install script

## Setup

Requires [tmux](https://github.com/tmux/tmux/wiki/Installing) and [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

```sh
curl -fLo dotfiles_setup.sh https://raw.githubusercontent.com/RamtinTJB/Dotfiles/refs/heads/main/dotfiles_setup.sh
chmod +x dotfiles_setup.sh
./dotfiles_setup.sh
```

The script installs vim-plug and TPM, then checks out the dotfiles into your home directory. Existing files are backed up to `.config-backup`.

After setup, install plugins:
- Vim: `:PlugInstall`
- Tmux: `prefix` + `I`

## Vim

**Theme:** Catppuccin Mocha (Dracula and Gruvbox also included).

**Plugins** (via [vim-plug](https://github.com/junegunn/vim-plug)): fzf, fugitive, coc.nvim, commentary, surround, gitgutter, airline, auto-pairs, vim-tmux-navigator, and a few more.

**Notable config choices:**
- `jk` to exit insert mode, arrow keys disabled
- Leader: `,` — local leader: `\`
- `,,v` / `,,s` to open and source vimrc
- LSP via COC (definitions, references, type info)
- 4-space indent by default, 2-space for JS/TS/JSON/YAML/HTML/CSS

## Tmux

**Prefix:** `CTRL-Space` on Linux, `CTRL-a` on macOS.

**Notable config choices:**
- Vi mode with `hjkl` pane navigation
- `|` and `-` for horizontal/vertical splits (preserves cwd)
- `Space` to toggle last window
- Windows and panes start at 1
- Dracula theme with CPU/RAM in the status bar
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for seamless movement between vim splits and tmux panes

## Claude Code

### Configuration

- **Model:** Opus, effort level set to high
- **Plugins:** skill-creator, clangd-lsp, rust-analyzer-lsp
- **Status line:** Custom script showing model name, git branch/status, context window usage %, and daily/weekly token consumption (tracked via a local JSONL log)

### Skills

| Skill | Description |
|-------|-------------|
| `commit-succinct` | Stage and commit with a short message |
| `gws-calendar-insert` | Create Google Calendar events from the terminal |
| `obsidian-weekly-summary` | Aggregate Obsidian daily notes into a structured weekly review |
| `review-dirty` | Send uncommitted changes to Codex for independent code review |
