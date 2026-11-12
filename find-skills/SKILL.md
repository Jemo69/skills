---
name: find-skills
description: Find skills — discover and install agent skills from skills.sh. Use when the user asks how to do something that may already have a skill, asks whether a skill exists for some task, or wants to extend your capabilities.
---

# Find Skills

Discover and install skills from the open agent skills ecosystem.

## The Skills CLI

`npx skills` is the package manager for that ecosystem. Skills are modular packages that extend agent capabilities with specialized knowledge, workflows, and tools.

| Command | Purpose |
| --- | --- |
| `npx skills find <query>` | Search by keyword |
| `npx skills add <package>` | Install a skill from GitHub or another source |
| `npx skills check` | Check for skill updates |
| `npx skills update` | Update all installed skills |

Browse at <https://skills.sh/>.

## Step 1 — Understand what they need

Identify the domain (React, testing, design, deployment) and the specific task within it (writing tests, creating animations, reviewing PRs).

Done when: you can name the domain and the specific task, each in one sentence.

## Step 2 — Search

```bash
npx skills find <query>
```

Query vocabulary by domain:

| Domain | Queries |
| --- | --- |
| Web development | react, nextjs, typescript, css, tailwind |
| Testing | testing, jest, playwright, e2e |
| DevOps | deploy, docker, kubernetes, ci-cd |
| Documentation | docs, readme, changelog, api-docs |
| Code quality | review, lint, refactor, best-practices |
| Design | ui, ux, design-system, accessibility |
| Productivity | workflow, automation, git |

Many skills come from `vercel-labs/agent-skills` or `ComposioHQ/awesome-claude-skills` — search those repos directly when the default search comes up thin.

Results look like:

```
Install with npx skills add <owner/repo@skill>

vercel-labs/agent-skills@vercel-react-best-practices
└ https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices
```

Done when: the query returned named results you can read, or it returned nothing and you have said so.

## Step 3 — Present options

For each relevant skill, give the user the name, what it does, the install command, and a skills.sh link.

```
I found a skill that might help! The "vercel-react-best-practices" skill provides
React and Next.js performance optimization guidelines from Vercel Engineering.

To install it:
npx skills add vercel-labs/agent-skills@vercel-react-best-practices

Learn more: https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices
```

Done when: every option carries both its install command and its skills.sh link.

## Step 4 — Offer to install

```bash
npx skills add <owner/repo@skill> -g -y
```

`-g` installs globally at the user level; `-y` skips confirmation prompts.

Done when: the skill is installed, or the user declined.

## When nothing matches

Say plainly that no skill was found, offer to handle the task directly, and mention `npx skills init` if this is something the user does often.

```
I searched for skills related to "xyz" but didn't find any matches.
I can still help you with this task directly! Would you like me to proceed?

If this is something you do often, you could create your own skill:
npx skills init my-xyz-skill
```

Done when: the user knows there is no match and has a path forward.
