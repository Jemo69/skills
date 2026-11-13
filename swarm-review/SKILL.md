---
name: swarm-review
description: Swarm independent reviewers on a change until it scores 10/10 with every juror, then dogfood it like the operator who depends on it. Use when user says review, jury, panel review, second opinion, ask other models, swarm this, or before babysitting a PR to merge.
---

# Swarm-review

One reviewer is a sample. Two or three cheap reviewers cost less than one bad merge. Fuses a review loop (author vs fresh reviewer, until 10/10) with jury-style multi-model agreement reached through native delegation (opencode, herdr, or T3 Code — never hardcoded model names, they rot), fixed up under the step-4 fix loop, and closed by a `dogfood` gate that proves the change live.

## Rules

- Review code that already passes its checks. Run `dogfood` step 5 (prove-it loop) first; never review red code (exception: user explicitly asks to throw it away).
- Reviewers change nothing. They output verdict + findings only, plus append one line to the one-stop score log every round (no separate files per juror).
- Quorum is 10/10: every juror must say APPROVE with score 10/10. Anything less — one CHANGES vote, or any APPROVE below 10/10 — is another fix round. There is no round cap: loop until 10/10 across the board. Checkpoint: every 4 rounds without 10/10, report scores + what still blocks, and continue only on the user's go-ahead (this bounds cost without lowering the bar).
- Scope is the diff only (`jj status` short + merge-base diff). Unrelated files are out of scope and must not be touched.

## Steps

### 1 - Ready the change

`jj status` (clean except intended files), find base (`jj log --limit 5` or merge-base vs `origin/main`), run covering checks once. Write goal in one sentence + out-of-scope list.

Done when: goal sentence, file list, and green check output are all stated. Red checks = stop, fix first.

### 2 - Pick the jurors (native delegation, never model names)

Route the jury through the delegation native to where you are running — do not name specific models or versions:

- **In herdr:** spawn sibling reviewer agents of different kinds (`herdr agent start <name> --kind <kind>`, then `herdr agent prompt <name> "<brief>"`; see `herdr` skill). Different kinds are the model mix.
- **In T3 Code:** use the native MCP delegation tools — call `orchestrator_capabilities` once per thread, then one `delegate_task` per role below (brief, findings, objections). Every re-check is a new `delegate_task`; follow a running delegate's `next`, never poll; `task_cancel` anything you replace.
- **Otherwise (not in herdr or T3 Code — e.g. in opencode):** spawn reviewer subagents with different models (see `opencode-cli` skill: `opencode agent create --mode subagent --model ...` / `opencode run`), one subagent per role below.
- **No supported runner: stop and report.** Sequential same-model runs are not a jury — say which runner is missing instead of faking agreement.

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

Done when: every juror returned verdict + score + findings, or its failure is recorded as non-approval. Author appends one row per juror to the one-stop score log: `| round | juror/role | verdict | score | blockers | shoulds | top finding |`.

### 4 - Fix loop (until 10/10)

Fix loop — Orient (goal/state/gap/risks), Inspect every file before touching it, Decide one approach in a sentence, Act one atomic change at a time, Verify (tests + build + lint/type), Recover (read the full error, fix root cause, re-verify; stop the round and report after 3 failed recoveries on the same error). Fix blockers first, then shoulds, then ALL nits (nothing left open except nits explicitly waived with a reason the jurors accept). Smallest diff that satisfies all jurors; re-run `dogfood` step 5 on anything the fix touched. Re-send the SAME brief + new diff for the next round.

Done when: every juror says APPROVE with score 10/10 and the score log shows every round. Never settle for 9/10 — loop again. Every 4th round without 10/10, report the full score log + the blocking findings and wait for the user's go-ahead before burning more rounds.

### 5 - Dogfood the change (gate, not a bonus)

A 10/10 jury is necessary but not sufficient — reviewers read code, operators live it. Run the `dogfood` skill against the change before any handoff:

1. Follow `dogfood` steps 1-7 on the FRESH build with the fix applied, scoping the audit to every surface the diff touches plus one neighboring surface nobody re-checked.
2. The `dogfood` STRICT GATE applies unchanged: overall equals the MINIMUM surface score, advance only on 10/10.
3. Any dogfood deduction below 10/10 re-opens the step 4 fix loop (fix narrowly, re-run `dogfood` step 5), and the fix must go back through a full jury round (step 3) — a dogfood fix never skips re-review.
4. Record the dogfood scores table + evidence in the report and append it to `DOGFOOD.md` per the dogfood skill's step 7.

Done when: jury is unanimous 10/10 AND the dogfood run scores 10/10 on every surface with dual-channel evidence. A sub-10/10 dogfood run sends the change back to step 4, no matter what the jury said.

### 6 - Handoff (score log + PR body)

Report: full one-stop score log (every round, every juror), blocker/should/nit list with file:line and how each closed, fix commits, final dogfood step-5 evidence, dogfood scores table + evidence links + `DOGFOOD.md` entry. Only then hand to `babysitter` / `file-pr`. Never merge anything below the double 10/10 (jury + dogfood) as success — state FAIL + what still blocks 10/10 and where.

Hand the author a paste-ready PR body block (PR descriptions carry no attribution per `leaving-pr-comments`):

```md
## Jury (swarm-review)

| Round | Juror | Verdict | Score | Blockers closed |
|---|---|---|---|---|
| 1 | correctness | CHANGES | 7/10 | 2/4 |
| 1 | simplicity | APPROVE | 9/10 | 0/1 |
| 2 | correctness | APPROVE | 10/10 | 4/4 |
| 2 | simplicity | APPROVE | 10/10 | 1/1 |

## Dogfood

| Surface | Score | Evidence |
|---|---|---|
| <surface> | 10/10 | <path/link> |

## Commits

- <sha> <what changed>
```

The table is built from the score log — no new scoring at handoff, just formatting.
