---
name: vault-lint
description: Check the vault for broken structure and report problems. Run weekly, or when the user asks to clean up the vault.
---

# vault-lint

The period for this check starts at the most recent commit with the message `vault lint YYYY-MM-DD`. If that commit does not exist, the period is the last 7 days.

## Check the notes

Find these problems. Report each problem with its file path.

Check only notes, as `AGENTS.md` defines them. Do not check `_templates/`, `_skills/`, `00-inbox/`, `README.md`, `AGENTS.md` or `CLAUDE.md`. These files do not use the 7 front matter fields.

- A note that does not have all 7 front matter fields.
- A `status` value that is not in the list in the `README.md` of its folder. If the folder has no list, use the list in `AGENTS.md`.
- A `product` value that is not in the product list in `AGENTS.md`.
- An empty `product` field in a folder whose `README.md` says that `product` is required.
- A front matter value that still has `|` or `{{`. Values like these are placeholders from a template.
- A `[[link]]` to a note that does not exist.
- A file name that does not obey the naming rule of its folder.
- Files in `00-inbox/`. List each file and the date of the commit that added it: `git log --diff-filter=A --date=short --format=%ad -- <file>`. If the file has no commit, write "not committed".
- An action in `open-actions.md` that is past due or has no owner.
- A row in `linked-resources.md` with a local file that does not exist.
- A note with no links to it and no links from it. Report these notes. They can be correct.

## Check the changelog against git

Use these 2 commands. Replace `<date>` with the start of the period.

- `git log --since=<date> --date=short --format='%ad %h %s'` lists all commits.
- `git log --since=<date> --date=short --format='%ad %h %s' -- changelog.md` lists the commits that changed `changelog.md`.

Find these problems:

- A day with commits but no `## YYYY-MM-DD` entry in `changelog.md`.
- A commit that did not change `changelog.md`. Show the hash and the message, so that the user can add the missing reason.
- A changelog entry for a day with no commits. The work for that day possibly has no commit.

## Fix and commit

1. Fix only the trivial problems. A trivial problem is a missing field with a value that you know for certain, or a link with a typo.
2. List each fix that you made.
3. For all other problems, ask the user before you change a file.
4. Add a bullet to today's entry in `changelog.md`.
5. Commit the fixes with the message `vault lint YYYY-MM-DD`.
