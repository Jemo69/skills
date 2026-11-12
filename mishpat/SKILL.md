---
name: mishpat
description: Headless Selenium web testing — drive pages, screenshot, assert, record MP4. Use when the user says mishpat, test a web page, headless browser, selenium test, screenshot a page, record a test video, or helpful mode.
---

# Mishpat

Drive the web with headless Chromium (Selenium), screenshot every step, and record MP4s with local ffmpeg — no paid recording service. Project lives at `/home/jemo/projects/Mishpat/`, runnable as `mishpat` on PATH.

First-class consumers are coding CLIs (Claude Code, Codex, OpenCode, Pi): they drive it from the terminal, read `shots/` PNGs with vision, load this skill natively (symlinked into each CLI's skills dir), and call its headless tools over MCP (`mishpat-headless`).

## 1 - Orient

Confirm the CLI answers: `mishpat --help`. Commands: `shell`, `screenshot`, `run`, `agent`, `record`, `helpful`, `mcp`.

Done when: the help lists all seven commands.

## 2 - Headless test loop (default)

Agent opens a terminal, drives the invisible browser, reads screenshots:

```bash
mishpat shell --url <URL>     # REPL — full verb set, see below
mishpat screenshot <URL> --out shots/x.png
mishpat run tests/demo.json   # scripted: [{"action":"goto","url":...},{"action":"click_text","text":...},{"action":"wait","seconds":5}, ...]
mishpat agent --goal "<what to verify>" --url <URL> --max-steps 15   # LLM picks commands (needs OPENAI_API_KEY)
```

One action language everywhere (`run`, `record`, `shell`, `helpful`, MCP, agent): `goto snapshot click click_text type press scroll wait wait_for wait_idle js back forward reload dom console tabs tab checkpoint restore screenshot assert`.

Speed tricks: `js <expr>` reads/sets page state (auth tokens without the 60s UI login); `checkpoint <file>` + `shell --restore <file>` resumes logged-in; `wait_for <js-cond>` beats blind waits; `wait_idle` after `goto` on JS apps (prevents pre-hydration native submits); `click [N]` replays a snapshot ref without fighting CSS escaping; `--quiet` keeps stdout parseable; `--driver-port` isolates parallel runs. Driver death aborts loudly (`DRIVER_LOST`, exit 2) instead of accepting stdin into the void.

Every step auto-saves a PNG to `shots/` (session-prefixed, never overwritten) — read the file to SEE the page before choosing the next command. Prefer `snapshot` before `click`/`type` (use real selectors from the snapshot). `click_text` clicks by visible words when selectors repeat. Clicks auto-follow `_blank` links — check `tabs`. `dom raw` prints unwrapped HTML for grep. `console` shows JS errors without leaving the CLI. Failures are one-liners with retry hints, never stack traces.

Done when: every claim about the page is backed by a fresh screenshot or `assert`, and `run` reports PASS.

## 3 - Helpful / video mode (visible + MP4)

For demo videos — all local, free:

```bash
mishpat record --url <URL> --script tests/demo.json --out shots/demo.mp4  # scripted run -> MP4
mishpat record --url <URL> --out shots/tour.mp4                           # no script = auto-scroll tour clip
mishpat helpful --url <URL> --video-out shots/helpful.mp4                 # VISIBLE browser REPL, stitches MP4 on quit
```

`helpful` opens a real window (for screen-capture/voiceover with OBS) AND stitches a clean MP4 of the run on quit. Never send the user to a paid recorder — ffmpeg (`/usr/bin/ffmpeg`) does it.

Done when: the MP4 exists, plays, and shows each test step.

## 4 - Browser-use for agents (no visible window)

Serve headless Selenium as MCP (stdio) so any agent gets browser tools without opening a browser:

```bash
mishpat mcp                                # idle-timeout 60s default
mishpat mcp --idle-timeout 120            # keep longer for slow flows
mishpat mcp --idle-timeout 0              # never auto-quit (not recommended)
```

Tools: `browser_goto, browser_snapshot, browser_click, browser_type, browser_screenshot, browser_dom, browser_assert, browser_back, browser_click_text, browser_tabs, browser_tab, browser_console, browser_js, browser_wait_idle, browser_idle, browser_quit`. Wiring for `~/.config/opencode/opencode.json` is in the project README.

Idle auto-kill (default 60s): Chromium quits after 60s with no tool calls — kills the orphan `chromium --headless` pileup (one MCP per agent session). Next tool call relaunches transparently. Check with `browser_idle`, force-close with `browser_quit`. Same flag on `shell/run/record/helpful`: `--idle-timeout 60`. REPL has an `idle` command. One-shot `screenshot` uses `idle-timeout 0` (quits immediately anyway).

Done when: the agent can snapshot, click, type, and screenshot with no window on screen.
