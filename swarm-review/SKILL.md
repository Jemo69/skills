---
name: swarm-review
description: Swarm independent reviewers on a change until they agree. Use when user says review, jury, panel review, second opinion, ask other models, swarm this, or before babysitting a PR to merge.
---

# Swarm-review

One reviewer is a sample. Two or three cheap reviewers cost less than one bad merge. Fuses a review loop (author vs fresh reviewer, cap 4) with jury-style multi-model agreement wired to your actual harness (`opencode-go/deepseek-v4.1-flash` + `muse-spark`, fallback fresh contexts).

## Rules

- Review code that already passes its checks. Run `prove-it` first; never review red code (exception: user explicitly asks to throw it away).
- Reviewers change nothing. They output verdict + findings only.
- Quorum: every juror must say APPROVE. One CHANGES vote = another fix round. Cap 4 rounds, then hand back with dissent quoted.
- Scope is the diff only (`jj status` short + merge-base diff). Unrelated files are out of scope and must not be touched.

## Steps

### 1 - Ready the change

`jj status` (clean except intended files), find base (`jj log --limit 5` or merge-base vs `origin/main`), run covering checks once. Write goal in one sentence + out-of-scope list.

Done when: goal sentence, file list, and green check output are all stated. Red checks = stop, fix first.

### 2 - Pick the jurors

Default panel (strongest mix available, high reasoning):

1. `opencode run -m opencode-go/deepseek-v4.1-flash "<brief>"` — correctness + edge cases
2. `opencode run -m opencode-go/muse-spark-1.3-contributor "<brief>"` (or current muse-spark model) — simplicity + scope discipline

Fallback when a second model is unreachable: two fresh-context runs of the current model, one prompted as `correctness: find wrong behavior`, the other as `simplicity: find what to delete`. Record which panel was used.

Done when: juror identities + roles are named before any review starts.

### 3 - One brief for all jurors

Same prompt to every juror, standing alone:

```
Repo path: <cwd> | Base: <base rev> | Diff: <exact diff command>
Goal in one sentence: <goal>
Out of scope: <list>
Checks: <command + result>
Review only, change nothing. Reply: verdict APPROVE|CHANGES, score /10,
findings as: id severity(blocker|should|nit) file:line claim fix
```

Launch all jurors in parallel (separate `opencode run` calls or subagents with own tags). Wait for all. A timeout or error is never approval.

Done when: every juror returned verdict + score + findings, or its failure is recorded as non-approval.

### 4 - Fix loop (max 4)

Fix blockers first, then shoulds. Nits only if trivial. Smallest diff that satisfies all jurors; re-run `prove-it` on anything the fix touched. Re-send the SAME brief + new diff for the next round.

Done when: all jurors say APPROVE, or 4 rounds elapsed with dissent quoted verbatim.

### 5 - Handoff

Report: per-juror verdict + score, blocker list with file:line, fix commits, final `prove-it` evidence. Only then hand to `babysitter` / `file-pr`. Never merge a split-jury change as success — state FAIL + who still objects and why.
