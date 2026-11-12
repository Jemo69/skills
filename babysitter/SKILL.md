---
name: babysitter
description: Babysit an open PR until it lands or dies. Use when the user says babysit, watch, or stay on a PR until it merges.
---

# Babysitter

Stay on a PR until it lands or dies. The user hands it over so they can walk away, so do the
work yourself: resolve conflicts, fix CI, answer reviewers, press the merge when the PR earns
it.

One step at a time — clear a step's bar before opening the next.

## Terminal states

The watch closes on exactly one of these, and the report names which:

- Merged.
- Closed unmerged.
- High-risk, staged merge-ready, waiting on the user's go-ahead.
- CI failed 3 consecutive runs despite fixes — hand back with the logs.
- The user says stop.

## Steps

### 1. Find the PR

Confirm a PR exists, is open, and runs head → base on a non-default branch.

Done when: the PR number is confirmed and its head and base branches are named.

### 2. Get CI green

Read the checks on every commit in the PR (`gh pr checks <n>`). On a red job, pull its log
(`gh run view <run-id> --log-failed`), diagnose, patch, push, and watch the re-run. Three
failed fix attempts hand the PR back with the logs attached.

Done when: every required check is green on the head commit, or three fix attempts have
failed and the hand-back is written.

### 3. Answer the reviewers

Read every thread — `gh pr view <n> --comments` plus the review bodies. Answer inline when
the answer is a code fix or a fact you can check; a comment needing a product decision goes
to the user, named in the report.

Done when: no thread on the head commit is unanswered, and every comment routed to the user
is named in the report.

### 4. Review and fix the diff

Dispatch a subagent to review the diff independently; when the subagent has no shell or file
tools, read `gh pr diff <n> --patch` yourself and open the changed files. Fix what blocking
findings name, right here — the merge step inherits no open findings.

Done when: every file in the diff is ranked blocking or non-blocking with file references,
and every blocking finding is fixed and pushed, or the report names it as the blocker.

### 5. Clear the path

Resolve merge conflicts on the PR branch: merge base in, keep the correct side, push.

Done when: `gh pr view <n> --json state,mergeable,mergeStateStatus` reports OPEN,
MERGEABLE, with required checks green on the new head. Without branch protection, that is
sufficient readiness.

### 6. Merge or hand back

**The 2am test.** Migrations, auth, payments, infrastructure, or several concerns in one PR:
that's the user's merge, not yours — stage it merge-ready and end the report with the
go-ahead request. Anything else is yours: `gh pr merge <n> --squash --delete-branch`.

Done when: the PR is MERGED, or it is merge-ready with the go-ahead request written.

### 7. Report

Name the terminal state, what you did to reach it, and what the user now owns: open review
threads, failing logs, the merge waiting on them.

Done when: the outcome is reported and names its terminal state.
