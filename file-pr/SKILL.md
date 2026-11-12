---
name: file-pr
description: File a PR when the user says "file-pr" or asks to push work to a separate branch or bookmark. Confirm a non-default branch, verify todos and user intent, then write an outcome-focused title and description.
---

# File PR

When the user asks you to file a PR, run these steps in order. Each step ends when its completion criterion is met.

## 1 - Confirm the branch

Make sure you are on a branch that is not the default branch.

Done when: `git branch --show-current` returns a branch other than the default.

## 2 - Verify the todos

Check your todo list and confirm everything is finished.

Done when: every todo is completed or explicitly marked out of scope.

## 3 - Confirm the user's intent

This is the most important step. Your code must meet the user's intent — what the user had in mind — not just the literal prompt. You can know the intent from a specific goal the user gave, their approval of the work, or a skill they named in the prompt.

Done when: you can state the user's goal in one sentence and name the commits that satisfy it.
### 3.5 - Do a local review of the code 
This check code quality and style and check if a change conflict with other pr and try to address the change 
prove it and asset generated in the prove it skill show be apodted in pr body

## 4 - Write the PR title

The title describes the outcome, not the code change.

```md
# Bad Example
feat(freenote): add rich-text (TipTap) editing mode- #1

# Good Example
feat(freenote): FreeShow gains a proper WYSIWYG rich-text editor for projections
```

## 5 - Write the PR description

The description describes the outcome, not the code change.
if the pr body has media refer to the `slop-media` skill
and add media to prove the job if need 


Done when: the title and description both name the outcome, and the PR is open with the correct base and head branches.

