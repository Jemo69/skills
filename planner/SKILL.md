---
name: planner
description: Plan a task the way I like it — interview for shared understanding, then produce the plan as an HTML file and publish it with the plan-cli skill. Use when the user wants to plan a task, create a plan, discuss an implementation approach, or create a new project for their work.
---

# Planner

This skill helps you plan a task before any code is written. The deliverable is an HTML plan file that gets published via the `slop-plan` skill.

## Tools I use (your plan should account for these)

- `uv` for Python
- `bun` for TypeScript/JS
- `jj` for version control when the repo has a `.jj` directory

## You MUST do these steps before proceeding

1. **Capture vocabulary.** When the user gives you a task, ask for the terms and vocabulary they use to think about the problem. Record this vocabulary in the plan's own notes section (NOT in AGENTS.md — that is global config and must not be mutated per task). Capture the goal and where the user said the project is heading (e.g., "this project is a ProPresenter killer", "this project is a CLI to make planning for agents easier").
2. **Explore the codebase.** Understand the current state before proposing anything.
3. **Interview relentlessly, one question at a time.** Interview the user about every aspect of this plan until you reach shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer. Ask one question at a time, waiting for feedback before continuing; asking multiple questions at once is bewildering. If a question can be answered by exploring the codebase, explore instead of asking. Done when: you can restate the plan's goal and the user's vocabulary back to them and they confirm it.
4. **Write the plan as an HTML file**, named after the plan (e.g., `plan-name.html`), styled per [STYLE.md](STYLE.md) — which routes to the `encase` design language. Write the plan's prose in the builder voice per the `writer` skill: direct, candid, pragmatic, no marketing fluff. All plans must render as mobile-friendly standalone pages: responsive layout, no horizontal scroll, no modals or overlays. **Exception:** when the user explicitly asks you to generate a demo UI (a clickable prototype, mockup, or preview of the interface itself), style the plan page to match the user's requested demo rather than forcing encase — encase still applies to everything else.
5. **Publish it** with the `slop-plan` skill (see "Publish" below).

## How the plan should be structured (in the HTML file)

The plan is for both the user and the agent. It must contain:

1. The **plan name** and the **main goal** of the plan.
2. The **files being modified** and the **files being created**, in two separate sections.
3. The **phases** of the plan, in execution order.

## Researchable

Used when the user gives you links to research, or asks you to research before planning.

- If the user gives a link, read the data in it and use it to make a better plan.
- If the user asks you to research then plan, look for a set of options.
- Add the options to the plan.
- When planning, write a separate plan file **per option**.
- Then create a **report** of which plan is best.

### Report

The report is a short, readable response in the chat window. For each option list its advantages and disadvantages, and end with a recommendation of the best option.

## Publish

When the plan is finalized, publish it with the `slop-plan` skill — verify auth, create a new project, then create the plan (private by default). Publish only when the user asks to share.

Completion criterion: the plan is created with the project ID and title confirmed by the CLI.
