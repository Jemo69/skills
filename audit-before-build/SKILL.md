---
name: audit-before-build
description: Research-only codebase audit before building — inventory features, map structure, check history. Use when the user says audit, inventory, research, explore, what is the current state, or what do you think of this project.
---

# Audit Before Build

Research-only. Do not edit files, commit, push, or run state-modifying commands. Map what exists so the build decision is grounded.

## 1 - Read the docs set

Read ARCHITECTURE.md, AGENTS.md, README, and PRODUCT.md when present. Prefer the src/ tree over docs claims when they disagree.

Done when: the project's stated purpose, stack, and entry points are named with file references, or the missing docs are listed as gaps.

## 2 - Map the structure

List the directories the task touches (src/types, feature folders, server/client split, build config, workflows). Mark each area exists, stub, or missing.

Done when: every area in scope has an exists-vs-stub verdict with paths.

## 3 - Check history

Run read-only history: `jj log --limit 10` and `jj status` (JJ repos) or `git log --oneline -20` and `git status` (git repos). Note recent work, open conflicts, and release config (package.json, electron-builder yaml, .github/workflows).

Done when: the last 10 commits are summarized and the working-copy state (clean/dirty/conflicted) is stated.

## 4 - Answer the question asked

Inventory (features + where they live), research (how a subsystem works: ports, protocols, data flow), or state (what works, what is stub, what is next). One table, file references on every row.

Done when: the output is a table with paths, no edits were made, and no state-modifying command ran. If the user also said fix or build, stop here and name `fix-it-all` as the next step instead of continuing into it.
