---
name: prove-it
description: Prove a change works with real evidence, not claims. Use when user says prove it, verify, show evidence, does it work, or before claiming any fix done, filing a PR, or babysitting.
---

# Prove-it

No credit for effort. A fix is done only when a real check plus user-visible proof both pass on the fresh build.

Fuses a tight verify loop (small steps, hard cap) with `dogfood` (dual-channel, harsh gate) and your harness (`boaz`/`mishpat`, WSL real paths, `jj`/`uv`/`bun`).

## Rules (apply every run)

- **Check before edit.** Name the narrowest real check first (one test file, `typecheck`, build, `boaz screenshot`, `mishpat run`). Run it once for a baseline.
- **Toolchain:** `uv run` for Python (never raw `python`/`pip`), `bun`/`bunx` for JS (never `npm`/`npx`), `jj status` / `jj log` for VCS (never `git` commands).
- **No mockups.** Windows `C:\Users\...` reads via `/mnt/c/...`. Screenshots must be fresh captures of the current build, never substitutes. If the file is missing, stop and ask for re-upload.
- **Two channels.** Every claim needs code-side proof (test/typecheck/log) AND user-side proof (screenshot, recording, CLI stdout, exit code). When they disagree, believe the user-facing one.
- **Cap:** max 5 verify rounds. On the 5th failure, stop and hand to `unstick` logic (name the shared assumption, probe it) — never a 6th variation.

## Steps

### 1 - Name the proof

Write one line: goal + check command + user-visible evidence (e.g. `fix lyric ranking | bun test search.test.ts | mishpat screenshot before/after`).

Done when: the check command is written down and its baseline output is recorded (pass/fail + output snippet).

### 2 - Smallest edit

Touch only files the goal needs (Strict Blast Radius). Read every file you will edit before editing. One logical change at a time.

Done when: `jj status` shows only intended files, and you can state why each file is in the diff.

### 3 - Run the check, read the first error

Run the exact command from step 1. Read the FULL output starting at the FIRST error (file:line + stack frame in your code), not the last line. Fix the root cause, not the symptom.

Done when: the check passes, or the first-error text plus root cause is quoted. Skimming to the tail is a failed step.

### 4 - User-side proof (second channel)

Rebuild + relaunch, then capture what the user would see:

- Web: `mishpat screenshot <URL> --out shots/<name>.png` (+ DOM snapshot or console log).
- Desktop: `boaz screenshot` on a fresh launch (stale window = fail). If capture is blank, run `boaz doctor` and report `X apps capturable` / `GL apps capturable` before retrying.
- CLI/API: scripted invocation capturing stdout, exit code, side effects.

Done when: you hold a fresh artifact from THIS build (timestamped `shots/` file, stdout block, or trace) plus the step-3 proof, and both agree.

### 5 - Verdict

Report in this order: check command + result, evidence path(s), `jj status` short, what remains unproven. Claim DONE only when steps 3 and 4 both pass. Otherwise state FAIL + the exact next probe.

Done when: the user can re-run one command and see one artifact that proves the claim. No artifact equals not done.
