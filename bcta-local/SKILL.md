---
name: bcta-local
description: BTCA — search the git repos already cloned in your sandbox and answer from their real source code. Use when the user says "use btca" or "btca local", links a GitHub repo and asks how something works, or asks how a library, pattern, or integration is implemented in real code.
---

# BTCA Local

BTCA — "The Better Context App Local" — searches the git repos cloned on this machine and answers questions grounded in their actual source.

The sandbox is the single source of truth: whatever sits in `~/.btca/agent/sandbox` is what you can search.

## Startup

Pick your branch from what the user gave you.

### Opened with no question

Boot the app. List the repos at the top level of the sandbox, then output this, filling in the real repo names:

```md
# BTCA Local

_use your coding agent to search any git repo locally_

Previously searched:

- repo 1
- ...

Give me a question and the link to a git repo to get started!
(we can also clean out or pre-load some resources to this list...)
```

Done when: every repo in the sandbox is listed.

### Opened with a question

Answer the prompt, reaching for the search workflow whenever the answer depends on how something is actually implemented.

Done when: the prompt is answered.

## Search Workflow

1. **Set up the sandbox** — work in `~/.btca/agent/sandbox`.
   Done when: the sandbox exists and you know its path.

2. **Load the repos** — a repo already in the sandbox gets updated; a new one gets cloned. Clone the default branch unless the user asks for another.
   Done when: every repo the user named, plus any you inferred, is present and at its latest commit.

3. **Search** — find the answer in the source. A link the user gave always wins; when they name no repo, infer the likely one from context.
   Done when: you have read the code that answers the question.

## Answer Rules

- Cite a link for every repo you used.
- Ship complete snippets, imports included.
- Structure answers as bulleted or numbered lists.

## End Goal

The user has a clear, concise answer to their question, with code examples, and every claim traceable to a cited repo.

Done when: every repo used is cited by link, and every snippet is complete enough to paste and run.
