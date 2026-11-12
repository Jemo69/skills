# skills — global agent skills

Extracted from `Jemo69/dot-file` (`.agents/skills/`, commit `ab89232`).
Global-only: pi / opencode personal skills are NOT included.

## Layout

Each top-level dir is one skill with a `SKILL.md`:

audit-before-build, babysitter, bcta-local, boaz, computer-usage,
deslopify, dogfood, encase, file-pr, find-skills, fix-it-all, greak,
herdr, hill-climb, impeccable, leanrea, mhid, mishpat, modernize,
opencode-cli, planner, prove-it, shots, slop-media, slop-plan,
swarm-review, writer, writing-great-skills

## Install (fresh machine)

```sh
git clone https://github.com/Jemo69/skills.git ~/skills
./install.sh
```

`install.sh` links `~/dot-file/.agents/skills -> ~/skills`
(`~/.agents` already symlinks to `~/dot-file/.agents`, so it follows).
