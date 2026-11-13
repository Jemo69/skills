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
| `babysitter` | Sits on an open PR until it merges or dies: conflicts, CI, reviewers, merge. | "babysit", "watch this PR until it merges" |
| `bcta-local` | Answers from real source of repos already cloned on this machine. | "use btca", "how does this library work in real code" |
| `boaz` | Tests desktop apps (Electron/GPUI/Qt) on an invisible display: screenshot, click/keys, MP4. | "boaz", "test this GUI app headless" |
| `close-out` | Full autonomy to a merged PR: finish, prove, review, file, babysit, merge. | "close out" |
| `computer-usage` | Orients the agent to this machine: tools, configs, available skills. | "what can I do here", start of a session |
| `design-system` | Unified UI router: Encase tactical black/white for web + plan pages, MHID token-driven minimal for native apps. | building/styling any UI, formatting plan HTML |
| `deslopify` | Strips AI-generated slop: dead controls, fake canvases, blocking modals, bloat. | "deslopify", "clean up AI slop", "productionize this" |
| `dogfood` | Uses the app like its most demanding operator: harsh-score, hunt bug class, fix, verify. | "dogfood", "harsh review", "10/10 loop" |
| `file-pr` | Files a PR on a non-default branch with outcome-focused title/body. | "file-pr", "push this to a PR" |
| `herdr` | Herds sibling panes/agents/workspaces: inspect, spawn, prompt, reap. | "herdr", "sibling agent", "background command" |
| `hill-climb` | Races N cheap attempts on a real metric, keeps winner, grafts losers' ideas. | "hill-climb", "benchmark", "make it faster" |
| `impeccable` | Designs/iterates production frontend: shape, critique, polish, live browser iteration. | "design", "redesign", "polish", "audit this UI" |
| `leanrea` | Reverse-engineers shipped software with plain CLI tools: bundles, binaries, APKs, pcaps. | "how does this app work", "extract versions/deps" |
| `leaving-pr-comments` | Attribution format for GitHub comments written on your behalf. | leaving any PR comment |
| `mishpat` | Drives headless Chromium via Selenium: assert, screenshot, record MP4. | "mishpat", "test this web page", "headless browser test" |
| `modernize` | Brings old PRs up to date (rebase onto latest). | "modernize", "rebase this PR" |
| `opencode-cli` | Recipes for driving OpenCode from CLI: run, serve, sessions, auth, plugins, ACP. | OpenCode CLI subcommand or headless/CI use |
| `slop-media` | Uploads screen recordings/screenshots, returns embed markdown for PR bodies. | "embed video in PR", "share a screenshot" |
| `slop-plan` | `plan` CLI: create, manage, publish HTML plans. Backing store for planner. | "publish a plan", "list plans" |
| `stage-it` | Same as close-out but leaves the PR open, never merges. | "stage it" |
| `swarm-review` | Swarms independent reviewers to 10/10 with a one-stop score log + PR-body table. | "review", "second opinion", "swarm this" |
| `writer` | Writes in the builder voice: pragmatic, in-the-trenches technical prose. | "write an article / teardown / manual" |
| `writing-great-skills` | Reference for writing predictable skills: vocabulary and principles. | writing or editing a skill |

## How they connect

```
close-out / stage-it
  ├── dogfood (prove every change, step 5 loop)
  ├── swarm-review (jury before filing)
  │     ├── dogfood (10/10 gate after jury)
  │     └── opencode-cli / herdr (spawn juror agents)
  ├── file-pr (open the PR)
  └── babysitter (watch to terminal state)
        ├── leaving-pr-comments (replies, with attribution)
        └── slop-plan (visual status page, only on demand)

dogfood
  ├── boaz (desktop proof) / mishpat (web proof)
  ├── hill-climb (winner validated by dogfood step 5)
  └── slop-media (evidence embeds for PR bodies)

design-system
  ├── impeccable (obeys the active branch, never invents tokens)
  └── slop-plan (Encase branch styles plan HTML, writer voices the prose)

modernize ── leaving-pr-comments (replies, with attribution)
file-pr ── leaving-pr-comments (descriptions carry no attribution)
```

Rule of thumb: capabilities live in exactly one skill; the rest point at it.
`dogfood` step 5 is the shared prove loop, `slop-plan` the shared publisher,
`leaving-pr-comments` the shared comment format, `herdr` the shared topology.
