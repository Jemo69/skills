---
name: fix-it-all
description: Finish-and-verify loop — fix, rebuild, push, release, verify deploys. Use when the user says continue, fix it all, just move, do not ask questions, or make sure everything deploys.
---

# Fix It All

Close out the task with no clarifying questions. Resolve ambiguity from AGENTS.md and the repo, then drive fix → rebuild → push → release → verify until green.

## 1 - Resolve without asking

Read AGENTS.md (global + project), PRODUCT.md when present, and the recent session context. Decide every open question yourself with the smallest sensible default.

Done when: every blocker has a decision and its source (AGENTS.md rule, repo convention, or prior user choice) is named. No question is left for the user.

## 2 - Fix

Fix the reported failure and anything it directly broke. Smallest change that works; do not expand scope.

Done when: the original repro passes and no new error appears in the touched path.

## 3 - Rebuild

Rebuild everything the fix touches: install deps if lockfiles changed, rebuild the app, rebuild releases (Electron builder, web bundles) when the project ships them.

Done when: a clean build succeeds with no errors. Warnings are listed, not fixed unless they break the build.

## 4 - Push and release

Commit on the current branch (JJ: `jj log --limit 5` / `jj status` first; never assume git). Push, create or update releases, push every target the project deploys.

Done when: `jj status` (or `git status`) is clean of intended work, the branch is pushed, and releases exist for every ship target.

## 5 - Verify deploys

Check GitHub CLI (`gh pr checks`, `gh run view --log-failed`) and Vercel CLI for deploy state. Fix red checks and re-verify; three failed fix attempts hand back with logs attached.

Done when: every target reports green, or the hand-back names the failing log and what was tried.

## 6 - Report

One line per target: green or red, the commit/release, the proof observed (command output, repro pass, deploy URL).

Done when: the report names each target's state and the user owns nothing except red items handed back.
