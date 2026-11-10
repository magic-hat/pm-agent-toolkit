# PM agent toolkit

A starter "second brain" for product managers who work with AI agents. It's a folder of plain markdown with git underneath, laid out so any agent you start in it knows where things go and how you like them done.

I built it from scratch with Claude Code to mirror the setup I use every day. It builds on the ideas Andrej Karpathy laid out in his [LLM wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), where the agent keeps a markdown wiki current from your raw notes instead of digging through them every time you ask something. I've adapted them a lot as I used the vault for PM work. The examples come from Meterly, a company I made up.

> **If you are an AI agent** and the user asks you to set up a vault from this repo, follow [`SETUP_PROMPT.md`](SETUP_PROMPT.md).

## Why it's built this way

No vector database. For one person's working memory, a sensible folder tree, consistent front matter and links get you surprisingly far, and a local vector DB felt like overkill. I change my process a lot, though, so who knows.

It works with any agent. The rules live in `AGENTS.md`, and `CLAUDE.md` just points there. I've moved between Claude Cowork, Claude Code in the terminal, a couple of open-source harnesses and the Claude desktop app, and the vault came with me each time without a migration. The only real chore was reconnecting my MCP servers.

Git keeps the history. Every change gets committed, and a hook nudges the agent if it tries to stop with uncommitted work. Commits only tell you what changed, so there's also `changelog.md`: every session that changes something adds a line to today's entry saying what it did and what's still open. When I want to know why a file looks the way it does, I find the commit and read that day's entry.

Obsidian is optional. The layout follows its conventions (front matter, `[[links]]`, underscore folders), so you can open the vault there. I rarely do. I edit in my agent's own document view and save back to the vault.

## Quick start

Start Claude Code, Codex or another coding agent in your home folder and paste this in:

```text
Set up a PM vault for me from https://github.com/magic-hat/pm-agent-toolkit. Clone the repo to a temporary folder, then read its SETUP_PROMPT.md and follow it.
```

You need an agent that can run commands on your computer. A chat window in the browser can't clone the repo or run the install.

It asks where the vault should go, what you own and which tools you use. Then it runs `install.sh` and fills in the rest.

Rather run the script yourself?

```bash
git clone https://github.com/magic-hat/pm-agent-toolkit
cd pm-agent-toolkit
./install.sh ~/vault
```

Then start your agent in `~/vault` and paste in everything below the line in [`SETUP_PROMPT.md`](SETUP_PROMPT.md). It skips the install step and does the rest.

On Windows, use WSL (Windows Subsystem for Linux) and everything above works as written. Without WSL, just ask your agent: `install.sh` needs a Unix shell, so the agent does the same steps by hand.

## Where to put it

`~/vault`, right in your home folder. It's a short path to add from any repo, and an agent started from home can see it. Keep it out of other git repos (`install.sh` checks). Keep it out of iCloud Drive, Dropbox and OneDrive too, because sync tools and git don't get along.

## What's inside

```
install.sh                 copies the template, makes the first commit
SETUP_PROMPT.md            what your agent follows to set you up
vault/
├── AGENTS.md              rules every agent reads first
├── CLAUDE.md              points to AGENTS.md
├── open-actions.md        everything you or others owe
├── linked-resources.md    notes with a shared copy elsewhere (push-only sync)
├── changelog.md           what each session did and why, one entry per day
├── 00-inbox/ … 13-projects/   14 working folders, each with its own README
├── _templates/            daily note, meeting, person, PRD, project, customer feedback, goals
├── _skills/               daily-note, meeting-from-transcript, meeting-brain-dump,
│                          meeting-prep, process-inbox, vault-lint,
│                          weekly-career-check, share-doc
├── _daily/  _dashboards/  _attachments/  _archive/
└── .claude/               commit-reminder hook, plus a link to _skills/
```

The folder READMEs do most of the work. Each one tells the agent how to name files, which front matter to use and what to capture, so the rules sit right next to the notes they're about.

## A normal week with it

- The first session each morning writes today's note from your open actions and calendar. If you want, it also sends you a short summary.
- Every session that changes something adds a line to the changelog before it commits, so the next one can see what happened earlier in the day.
- After a meeting, paste the transcript or do a quick brain dump. The agent writes the meeting note, adds the actions to `open-actions.md` and updates the people notes.
- Before a meeting, ask for prep. You get the open actions and recent context for everyone in the room.
- Once a week, `vault-lint` checks front matter, links and the inbox, and catches commits that never made it into the changelog. `weekly-career-check` asks whether the week actually moved your goals.

## Using it from a code repo

Start your agent in the repo and add the vault as a second folder. How you do that depends on the tool. I use Claude Code in the Claude desktop app, where I set up a local workspace for each repo, say `~/code/meterly/`, and include the vault folder when I create it. Every session in that workspace gets both. That's a desktop app feature right now, and I don't know if it'll stick around or whether other apps have anything like it. For a single session there, **+ → Add folder** works. In the terminal, it's `claude --add-dir ~/vault`. For other agents, check how they add a second folder. The agent works in the repo and can still read your context.

Two things don't come along, though. Claude Code loads the vault's skills from an added folder, but it doesn't read the vault's `AGENTS.md`, and the commit hook doesn't run. The fix for the first is one line in `~/.claude/CLAUDE.md` (setup offers to add it for you):

```
If `~/vault` is an added directory, read `~/vault/AGENTS.md` before you change files in `~/vault`, and obey its rules there.
```

The hook only runs in sessions you start in the vault itself. With that line in place, the agent still knows to commit, because the rule is in `AGENTS.md`.

## The catch

It's all local. Close the laptop and nothing can reach the vault, which is annoying when an idea hits while I'm away from my desk. I haven't found a fix I like yet.

## Before you put work in it

Check your company's policy on what work information can live in local files and go to AI tools. The templates assume you follow it. They can't enforce it.

## License and contributing

MIT (see [`LICENSE`](LICENSE)). Do what you like with it. If you publish your own version, keep the license file so the credit comes along.

Issues and pull requests are welcome.
