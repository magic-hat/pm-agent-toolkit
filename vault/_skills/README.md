# Skills

Each folder has a `SKILL.md` file. The file has a description, which tells an agent when to use the skill, and the steps.

The files are plain markdown, so any agent can follow them. Claude Code also loads them as skills through `.claude/skills/`, which is a link to this folder.

| Skill | When to use it |
|---|---|
| `daily-note` | At the start of the day |
| `meeting-from-transcript` | After a meeting that has a transcript |
| `meeting-brain-dump` | After a meeting that has no transcript |
| `meeting-prep` | Before a meeting |
| `process-inbox` | When files are in `00-inbox/` |
| `vault-lint` | One time each week |
| `weekly-career-check` | One time each week |
| `share-doc` | When the user shares a note outside the vault |
