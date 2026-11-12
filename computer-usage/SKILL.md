---
name: computer-usage
description: Environment orientation for AI agents. Use when starting a new session, asked "what can I do here", or when another skill needs to know what tools and configs exist on this machine.
---

# Computer Usage

Orients the agent to this machine: what's installed, what's configured, what skills are available. The agent reads the live environment, not a snapshot.

## Setup

Run once per session. Skip if you've already seen the output.

```bash
node .agents/skills/computer-usage/scripts/scan-config.mjs
```

The scan script is the single source of truth for this machine: it inventories installed tools, shell aliases, config directories, MCP servers, and available skills from the live config.

If the script is missing, fall back to manual discovery:

1. `ls ~/.config/` — list installed tool configs
2. `cat ~/.zshrc` — read shell aliases and PATH
3. `cat ~/.config/opencode/opencode.json` — read MCP servers and providers

## Plan CLI

The full `plan` CLI reference — auth, projects, create, list, publish — lives in [reference/plan-cli.md](reference/plan-cli.md). Read it when the task involves creating, publishing, or managing a plan.

## Completion Criterion

You are oriented when you can answer all three without re-running the scan or re-reading the script:

1. Can you name at least 5 installed tools and 2 shell aliases?
2. What editors are installed?
3. How do you publish a plan? (read reference/plan-cli.md if you cannot answer from memory)