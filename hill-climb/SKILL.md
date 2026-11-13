---
name: hill-climb
description: Hill-climb a measurable optimization with parallel attempts and grafting. Use when user says hill-climb, benchmark, make it faster, best of N, try a few versions, optimize search, or 50x faster.
---

# Hill-climb

One attempt is a sample. Race N cheap attempts on a real metric, keep the winner, graft the best ideas from losers. Fuses a best-of-N parallel race (race + graft) with your benchmark habit (oma-cast lyric/app-search work) and run-ledger memory.

Built for DeepSeek-cheap parallelism: 3–5 attempts cost less than one round of fixing a bad first try.

## Rules

- **Metric first.** No race without a number: script + corpus + target (e.g. `bun run bench/search.bench.ts --corpus out/lyrics-hill-climb-folder | p50 ms, recall@5`). Metric script is committed before any attempt.
- **Toolchain:** `uv run` (Python) / `bun` (JS), `jj` for VCS. Each attempt gets its own output location — separate worktree (`jj new` / worktree per attempt) or `out/hillclimb/<attempt>/` — never shared files.
- **Attempts never see the rubric.** They get the task prompt + corpus path + metric command only. You keep the private rubric (3–6 checkable criteria: speed, correctness, blast radius, type safety).
- **Blast radius:** attempts may only touch their own location + the target module. No drive-by refactors.

## Steps

### 1 - Frame the race

Write: (a) one prompt every attempt gets unchanged (goal, corpus, metric command, constraints: single-responsibility, strict types, no `any`/untyped defs), (b) private rubric with 3–6 checkable criteria, (c) N (default 3, 5 when design space is wide).

Done when: metric script runs on the current code and its baseline number is recorded.

### 2 - Race

Spawn N attempts in parallel (subagents/worktrees, or sequential fresh contexts if no runner). Each returns: artifact in its own location + metric output + one-line note on alternatives it rejected.

Done when: all N metric outputs are collected with pass/fail. Discard attempts that don't run; a crash is data, not a retry.

### 3 - Rank and graft

Rank by rubric (metric first, then correctness, then smallest diff). Pick the winner as base. Graft at most 1–2 best ideas from losers into the winner — never a three-way merge. Re-run the metric on the grafted result.

Done when: winner + graft source(s) are named, metric shows improvement over baseline, and `dogfood` step 5 (prove-it loop) passes on the grafted change.

### 4 - Ledger it

Append to the run ledger (`.hillclimb.tsv` or `PROGRESS.md`): date, baseline → winner numbers, attempts tried, what was grafted, what was rejected and why. Commit the metric script + winner so the next session can re-run one command.

Done when: one command reproduces the winning number and the ledger row exists. No ledger row equals not done — the next session will re-litigate it.
