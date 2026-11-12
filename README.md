# skills — global agent skills

Extracted from `Jemo69/dot-file` (`.agents/skills/`, commit `ab89232`).
Global-only: pi / opencode personal skills are NOT included.

## Install (fresh machine)

```sh
git clone https://github.com/Jemo69/skills.git ~/skills
./install.sh
```

`install.sh` links `~/dot-file/.agents/skills -> ~/skills`
(`~/.agents` already symlinks to `~/dot-file/.agents`, so it follows).

## Skills

| Skill | What it does | Say to use it |
|---|---|---|
| `audit-before-build` | Research-only repo audit: inventory features, map structure, check history. No edits. | "audit", "inventory", "what is the state of this project" |
| `babysitter` | Sits on an open PR until it merges or dies: conflicts, CI, reviewers, merge. | "babysit", "watch this PR until it merges" |
| `bcta-local` | Answers from real source of repos already cloned on this machine. | "use btca", "how does this library work in real code" |
| `boaz` | Tests desktop apps (Electron/GPUI/Qt) on an invisible display: screenshot, click/keys, MP4. | "boaz", "test this GUI app headless" |
| `computer-usage` | Orients the agent to this machine: tools, configs, available skills. | "what can I do here", start of a session |
| `deslopify` | Strips AI-generated slop: dead controls, fake canvases, blocking modals, bloat. | "deslopify", "clean up AI slop", "productionize this" |
| `dogfood` | Uses the app like its most demanding operator: harsh-score, hunt bug class, fix, verify. | "dogfood", "harsh review", "10/10 loop" |
| `encase` | JEMO CORE web design language: black/white contrast, hard borders, uppercase labels. | styling any web UI or plan page |
| `file-pr` | Files a PR on a non-default branch with outcome-focused title/body. | "file-pr", "push this to a PR" |
| `find-skills` | Discovers and installs skills from skills.sh. | "is there a skill for X", "extend your capabilities" |
| `fix-it-all` | Finish-and-verify loop: fix, rebuild, push, release, verify green. No questions. | "continue", "fix it all", "just move" |
| `greak` | Methodical agentic coding: think, ground in tools, verify, self-heal. | "greak", "fable mode", "code like fable" |
| `herdr` | Herds sibling panes/agents/workspaces: inspect, spawn, prompt, reap. | "herdr", "sibling agent", "background command" |
| `hill-climb` | Races N cheap attempts on a real metric, keeps winner, grafts losers' ideas. | "hill-climb", "benchmark", "make it faster" |
| `impeccable` | Designs/iterates production frontend: shape, critique, polish, live browser iteration. | "design", "redesign", "polish", "audit this UI" |
| `leanrea` | Reverse-engineers shipped software with plain CLI tools: bundles, binaries, APKs, pcaps. | "how does this app work", "extract versions/deps" |
| `mhid` | Cross-platform UI system blending Material 3 + Apple HIG via MHTS tokens. | building React/Svelte/Flutter/SwiftUI UI |
| `mishpat` | Drives headless Chromium via Selenium: assert, screenshot, record MP4. | "mishpat", "test this web page", "headless browser test" |
| `modernize` | Brings old PRs up to date (rebase onto latest). | "modernize", "rebase this PR" |
| `opencode-cli` | Recipes for driving OpenCode from CLI: run, serve, sessions, auth, plugins, ACP. | OpenCode CLI subcommand or headless/CI use |
| `planner` | Interviews for shared understanding, writes the task plan as HTML. | "create a plan", "plan this task" |
| `prove-it` | Proves a change with real evidence, not claims: fresh-build check + visible proof. | "prove it", "verify", "does it work" |
| `slop-media` | Uploads screen recordings/screenshots, returns embed markdown for PR bodies. | "embed video in PR", "share a screenshot" |
| `slop-plan` | `plan` CLI: create, manage, publish HTML plans. Backing store for planner. | "publish a plan", "list plans" |
| `swarm-review` | Swarms independent reviewers until they agree; cap 4 rounds. | "review", "second opinion", "swarm this" |
| `writer` | Writes in the builder voice: pragmatic, in-the-trenches technical prose. | "write an article / teardown / manual" |
| `writing-great-skills` | Reference for writing predictable skills: vocabulary and principles. | writing or editing a skill |
