---
name: herdr
description: "Herd panes, agents, and workspaces with herdr. Use when user mentions herdr, pane, sibling agent, second agent, background command, or --machine remote control."
---

# Herdr — herd sibling panes and agents

One leading word: **herd** — inspect, spawn, prompt, and reap background work without stealing focus.

## Setup

No git repo — herdr is a closed-source binary (https://herdr.dev). Already installed at `~/.local/bin/herdr`.

```bash
herdr status    # client + server must both answer
herdr update    # download and install the latest version
```
Docs: https://herdr.dev/agent-guide.md · https://herdr.dev/llms.txt

## 0. Gate (every run)

```bash
test "${HERDR_ENV:-}" = 1
```
Fail → say "not inside Herdr" and stop. Never control Herdr from outside it.
Never run bare `herdr` (attaches TUI). All control commands return JSON — parse IDs from responses, never from sidebar order or examples.

Caller context (injected per pane):
```bash
printf '%s\n' "$HERDR_WORKSPACE_ID" "$HERDR_TAB_ID" "$HERDR_PANE_ID"
```
`--current` = calling pane. Omitted targets = UI-focused pane (may be someone else's) — always pass explicit ID, name, or `--current`. New IDs come from `.result.pane.pane_id`, `.result.workspace`, `.result.tab`. Closed IDs are never reused; after `pane move` use `.result.move_result.pane.pane_id`.

## 1. Discover (herd the layout first)

```bash
herdr workspace list
herdr tab list --workspace "$HERDR_WORKSPACE_ID"
herdr pane list --workspace "$HERDR_WORKSPACE_ID"
herdr pane current --current
herdr agent list
herdr agent get <name-or-pane-id>
```
Full CLI authority: `herdr --help`, then `herdr agent|pane|workspace|tab|worktree|machine|notification|integration|session|api|config|channel|server` (group alone lists subcommands). Full schema: `herdr api snapshot`, `herdr api schema`.

## 2. Spawn agent (sibling pane, keep focus)

Default: sibling in current tab + current cwd. No new workspace/tab/worktree/cwd unless asked. Geometry: wide → `right`, narrow/tall → `down`:

```bash
herdr pane layout --pane "$HERDR_PANE_ID"
herdr pane split --current --direction right --cwd "$PWD" --no-focus
# → .result.pane.pane_id
herdr agent start <name> --kind <kind> --pane <new-pane-id> -- <agent-args...>
```
Names: `[a-z][a-z0-9_-]{0,31}`, unique among live agents. Kinds: `pi claude codex gemini cursor opencode copilot droid amp grok qwen` (+ `devin agy cline omp mastracode kimi kiro hermes kilo qodercli letta maki muse`). Pane must sit at interactive shell prompt. Success = agent detected + ready; `agent_not_ready` → `agent read` + wait for `idle` before prompting.

## 3. Prompt + wait (agent surface)

```bash
herdr agent prompt <name> "<task>" --wait --timeout 120000
herdr agent wait <name> --until blocked --timeout 120000   # only for state-specific waits
herdr agent read <name> --source recent-unwrapped --lines 120
herdr agent send-keys <name> esc            # esc | ctrl+c | enter …
herdr agent rename <old> <new> | herdr agent focus <name>
```
Rules: `--wait` alone waits settled (`idle|done|blocked`); add `--until` only for a specific state. Submission gate: must observe `working|blocked` within 5s or returns `agent_prompt_stalled` — never blindly resubmit; `agent get` + `agent read` first. `blocked` = approval/question UI → ask user before answering. `idle|done` = ready (not proof of no hidden dialog). `unknown` = present but unclassified. Target = live agent name **or** hosting pane ID (never terminal IDs / bare kind labels). Prefer agent surface; touch pane surface only for raw terminal control.

## 4. Run ordinary commands (pane surface)

```bash
herdr pane split --current --direction right --cwd "$PWD" --no-focus
herdr pane run <pane-id> "just test"
herdr pane wait-output <pane-id> --match "test result" --timeout 120000
herdr pane read <pane-id> --source recent-unwrapped --lines 120
herdr pane send-text <pane-id> "literal…"   # no Enter; pane run = text+Enter
herdr pane send-keys <pane-id> ctrl+c
```
`--match` = literal, `--regex` = Rust regex; snapshot searched immediately (existing output can match); omit `--timeout` = wait forever. Sources: `visible` viewport · `recent` with wraps · `recent-unwrapped` logs/transcripts (prefer) · `detection` agent snapshot. `--format ansi` only when color is evidence. `--lines N` pulls scrollback (alt-screen rows unavailable). Large-output fallback: agent writes Markdown to temp dir, replies with path, you read the file. macOS line-limit reject → wait for shell prompt, retry.

## 5. Topology + worktrees (only when asked)

```bash
herdr workspace create --cwd <path> --label <t> --no-focus
herdr workspace focus|rename|get|close <w-id>            # never --group to bypass guard
herdr tab create --workspace <w> --cwd <path> --label <t> --no-focus
herdr tab focus|rename|get|close <w:t>
herdr pane focus|resize|zoom|swap|move|close <w:p>        # move re-IDs pane; don't reuse old ID
herdr pane neighbor|edges|process-info|layout --pane <w:p>
herdr pane input|rename|report-agent*|release-agent|report-metadata --pane <w:p>
herdr worktree create --branch <b> --base <ref> --path <p> --label <t> --no-focus
herdr worktree open|list|remove                          # --trust-repository only after user verified repo
herdr notification show <id> | herdr integration install|uninstall|status
herdr session list|attach|stop|delete
```

## 6. Remote machines (same commands, one prefix)

```bash
herdr machine list --json
herdr --machine <label-or-id> agent list
herdr --machine <label-or-id> pane list
herdr --machine <label-or-id> agent prompt <remote-name> "status?" --wait --timeout 120000
```
Selector = enabled profile ID or unique case-sensitive label (not hostname). Same prefix on every command. Discover remote IDs there — local IDs / `--current` are meaningless remotely. Never combine `--machine` with `--session|--remote`. Never add/remove/enable/disable profiles, `machine reconnect` (user does SSH auth), or approve server replacement without being asked. Connection failure ≠ mutation failed — inspect remote state before retrying. Remote worktree paths must be absolute/`~`/`~/`.

## Safety

- `--no-focus` for background work; never steal focus unasked.
- Never close workspaces/tabs/panes/sessions you didn't create unless explicitly asked (no TUI last-pane confirmation on CLI).
- Never `herdr server stop` from an active session; never kill the main process; use named test sessions for experiments.
- Client/server version skew is normal after update — `herdr status` first; missing method ≠ permission to stop/upgrade.
- Errors: JSON on stderr, exit 1 = server error, 2 = syntax. `herdr config check|reset-keys`, `herdr server reload-config|agent-manifests`, `herdr channel show|set`, `herdr update` only when asked.
