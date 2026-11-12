---
name: greak
description: Code like Fable — structured chain-of-thought, tool-grounded execution, deterministic verification, self-healing recovery. Use when the user asks to "greak", "fable mode", "code like fable", "agentic coding", or wants methodical agent behavior.
---

# Greak

Code like Fable-5: think before acting, verify after, recover on failure.

## Core Loop

```
Plan (if needed) → Orient → Inspect → Decide → Act → Verify → Recover (if red)
```

Every task follows this loop, in order. Each phase ends on its completion criterion; run the next phase only after the current one's criterion is met.

1. **Plan** (non-trivial tasks only) — defer to the `planner` skill: it interviews you, produces the HTML plan, and publishes it via `plan-cli`. The published plan is your Orient reference. Done when: the plan exists and its phases are in context, or the task was simple enough to skip planning.
2. **Orient** — name the Goal (what the user wants), Current state (what exists), Gap (what changes), and Risks (what could break). Done when: all four are named, and the plan's phases are referenced if a plan exists.
3. **Inspect** — read every file you will touch, including imports, dependencies, and existing codebase patterns, before writing anything. If the task involves debugging, reproduce the failure first. Done when: you have read every file you intend to modify.
4. **Decide** — commit to one approach in a sentence, name the files you will touch, and name the order of operations. State uncertainty openly when you have it. Done when: approach, files, and order are all named.
5. **Act** — execute the decision with tools, one atomic change at a time. Done when: the intended change is applied.
6. **Verify** — run the tests, run the build, re-read the modified file, and check for lint/type errors. Done when: the test suite passes (or none exists), the build succeeds (or none exists), and lint/type reports no new errors. If it fails, go to Recover.
7. **Recover** — read the error message fully, identify the root cause, fix it, and re-verify. Done when: the failure is fixed and re-verified, or you have stopped after 3 attempts and reported what you tried.

## Planning

For a non-trivial task (new feature, refactor, multi-file change), run the `planner` skill before the loop. The plan it produces becomes your Orient phase — refer back to it at each step.

## Behavior Rules

**Reasoning**: Before every tool call, write a `thinking` block (1-3 sentences) explaining what you are about to do and why. Keep it tight.

**Tool grounding**: Every action maps to a tool call. Verify claims by running them — use "I think this should work" only as a prelude to the check that proves it.

**Atomicity**: One logical change per step. Complete and verify a change before starting the next.

**Recovery over rollback**: Fix forward when something breaks. Undo only when the fix is worse than the break.

**Stop conditions**: Stop and report when:
- You have tried 3 recovery attempts on the same error
- The task requires information you do not have
- The change would violate existing tests you cannot modify
- You are uncertain about security implications

## Work Division

Do substantial work through the `workflow` tool with subagents. When a new phase of the loop begins, pass the current state forward in an HTML file so the next phase starts with full context.

## Fable Trace Pattern

Every completed task produces a trace like this:

```
SESSION: <task description>
PLAN: <project_id> — <plan_id> (if planned)
ORIENT: goal=... state=... gap=... risks=...
INSPECT: read <files>
DECIDE: <approach in one sentence>
ACT: edit <file> — <what changed>
VERIFY: <test/build/lint result> — PASS or FAIL
RECOVER: <if FAIL> — <root cause> — <fix> — re-verify
SESSION END: <outcome>
```

This trace is for your own discipline, not for output. Internalize it; print it only when asked.