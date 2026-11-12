---
name: swarm-review
description: Swarm independent reviewers on a change until it scores 10/10 with every juror, then dogfood it like the operator who depends on it. Use when user says review, jury, panel review, second opinion, ask other models, swarm this, or before babysitting a PR to merge.
---

# Swarm-review

One reviewer is a sample. Two or three cheap reviewers cost less than one bad merge. Fuses a review loop (author vs fresh reviewer, until 10/10) with jury-style multi-model agreement reached through whatever model-calling skill is native to your harness — never hardcode model names or versions, they rot. Closed by a `dogfood` gate that proves the change live.

## Rules

- Review code that already passes its checks. Run `prove-it` first; never review red code (exception: user explicitly asks to throw it away).
- Reviewers change nothing. They output verdict + findings only.
- Quorum is 10/10: every juror must say APPROVE with score 10/10. Anything less — one CHANGES vote, or any APPROVE below 10/10 — is another fix round. There is no round cap: loop until 10/10 across the board. Checkpoint: every 4 rounds without 10/10, report scores + what still blocks, and continue only on the user's go-ahead (this bounds cost without lowering the bar).
- Scope is the diff only (`jj status` short + merge-base diff). Unrelated files are out of scope and must not be touched.

## Steps

### 1 - Ready the change

`jj status` (clean except intended files), find base (`jj log --limit 5` or merge-base vs `origin/main`), run covering checks once. Write goal in one sentence + out-of-scope list.

Done when: goal sentence, file list, and green check output are all stated. Red checks = stop, fix first.

### 2 - Pick the jurors (native delegation, never model names)

Reach the jury through the delegation skill native to your harness — do not name specific models or versions:

- **In opencode:** spawn reviewer subagents with different models (see `opencode-cli` skill: `opencode agent create --mode subagent --model ...` / `opencode run`), one subagent per role below.
- **In herdr:** spawn sibling reviewer agents of different kinds (`herdr agent start <name> --kind <kind>`, then `herdr agent prompt <name> "<brief>"`; see `herdr` skill). Different kinds are the model mix.
- **In pi or similar:** use the harness's native subagent/delegate tools (same pattern as the `greak` workflow/subagents loop).
- **Fallback (no runner):** sequential fresh-context runs of the current model, one prompted as `correctness: find wrong behavior`, the other as `simplicity: find what to delete`.

Default roles (strongest mix available, high reasoning):

1. Correctness + edge cases
2. Simplicity + scope discipline

Done when: the delegation route + juror roles are named before any review starts.

### 3 - One brief for all jurors

Same prompt to every juror, standing alone:

```
Repo path: <cwd> | Base: <base rev> | Diff: <exact diff command>
Goal in one sentence: <goal>
Out of scope: <list>
Checks: <command + result>
Review only, change nothing. Reply: verdict APPROVE|CHANGES, score /10,
findings as: id severity(blocker|should|nit) file:line claim fix
Scoring bar (hold it ruthlessly): 10/10 means zero blockers, zero shoulds,
and every nit either fixed or explicitly waived with a reason. 9/10 with
open shoulds is CHANGES, not APPROVE.
```

Launch all jurors in parallel through the native calls from step 2 (each with its own context, tag, or session). Wait for all. A timeout or error is never approval.

Done when: every juror returned verdict + score + findings, or its failure is recorded as non-approval.

### 4 - Fix loop (until 10/10)

Fix blockers first, then shoulds, then ALL nits (nothing left open except nits explicitly waived with a reason the jurors accept). Smallest diff that satisfies all jurors; re-run `prove-it` on anything the fix touched. Re-send the SAME brief + new diff for the next round.

Done when: every juror says APPROVE with score 10/10. Never settle for 9/10 — loop again. Every 4th round without 10/10, report per-juror scores + the blocking findings and wait for the user's go-ahead before burning more rounds.

### 5 - Dogfood the change (gate, not a bonus)

A 10/10 jury is necessary but not sufficient — reviewers read code, operators live it. Run the `dogfood` skill against the change before any handoff:

1. Follow `dogfood` steps 1-7 on the FRESH build with the fix applied, scoping the audit to every surface the diff touches plus one neighboring surface nobody re-checked.
2. The `dogfood` STRICT GATE applies unchanged: overall equals the MINIMUM surface score, advance only on 10/10.
3. Any dogfood deduction below 10/10 re-opens the step 4 fix loop (fix narrowly, re-run `prove-it`), and the fix must go back through a full jury round (step 3) — a dogfood fix never skips re-review.
4. Record the dogfood scores table + evidence in the report and append it to `DOGFOOD.md` per the dogfood skill's step 7.

Done when: jury is unanimous 10/10 AND the dogfood run scores 10/10 on every surface with dual-channel evidence. A sub-10/10 dogfood run sends the change back to step 4, no matter what the jury said.

### 6 - Handoff

Report: per-juror verdict + score (all 10/10), blocker/should/nit list with file:line and how each closed, fix commits, final `prove-it` evidence, dogfood scores table + evidence links + `DOGFOOD.md` entry. Only then hand to `babysitter` / `file-pr`. Never merge anything below the double 10/10 (jury + dogfood) as success — state FAIL + what still blocks 10/10 and where.
