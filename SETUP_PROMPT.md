# Setup prompt

This file is mostly for your agent. The easy way to use it: start Claude Code (or another coding agent) in your home folder and paste this in:

```text
Set up a PM vault for me from https://github.com/magic-hat/pm-agent-toolkit. Clone the repo to a temporary folder, then read its SETUP_PROMPT.md and follow it.
```

The agent asks you a few questions and does the rest. If you've already cloned the repo, you can paste in everything below the line instead.

---

**Goal:** build a vault for a product manager from the `pm-agent-toolkit` repo.

**Context:** in this prompt, "I" and "me" mean the user. The repo has `install.sh` and a template folder, `vault/`. The vault is the folder that you make from the template.

**Limits:**

- Do the steps in sequence. Before you do an action that is not in these steps, ask me.
- During setup, use the step order in this prompt. The start-of-session steps in `AGENTS.md` apply to later sessions.
- In this prompt, `<vault>` means the path of the vault folder that I select in step 2.
- Do not change my global git config without my approval.
- Do not change my global agent instructions (for example `~/.claude/CLAUDE.md`) without my approval.
- Do not create a scheduled task without my approval.
- Do not delete files, except the temporary clone in step 9.

**Steps:**

1. **Get the repo.**
   - If I already ran `install.sh`, skip step 1 and step 3. Do not skip step 2. You know that I ran `install.sh` if I say so, or if the session started in a folder with `AGENTS.md` and the commit `start vault`.
   - If you already have a clone of the repo, use that clone. For example, use the clone that you made to read this file.
   - If you do not have a clone, clone the repo into a temporary folder:

     ```bash
     git clone --depth 1 https://github.com/magic-hat/pm-agent-toolkit "$(mktemp -d)/pm-agent-toolkit"
     ```

   - On Windows without a Unix shell, select the temporary folder yourself.
   - Read `install.sh` before you run it. Tell me in one line what the script does.

2. **Ask me these questions, one at a time.** If I already ran `install.sh`, do not ask question 1. The vault is the folder that I ran it on.
   1. Where must the vault be? Recommend `~/vault`, a folder in my home directory. Give the reason in 2 sentences or fewer.
      - The reason: the path is short to add from any repo (`claude --add-dir ~/vault`). Also, an agent that starts in my home folder can see the vault.
      - If I select a different folder, the folder must be outside all other git repos.
      - Tell me not to use a cloud-sync folder (iCloud Drive, Dropbox, OneDrive). Sync tools and git do not work well together.
   2. What is my role, and what type of organization do I work in?
   3. Which products or areas do I own? My answer becomes the list of allowed values for the `product` front matter field.
   4. Which tools do I have connected: calendar, chat (for example Slack), docs (for example Google Docs), meeting transcripts?
   5. Do I have notes in a different location that I want to add to the vault? If yes, where are they?
   6. Do I want a short summary of each day sent to me? Ask this question only if I connected a chat tool. If yes, ask where it must go, for example a direct message to myself in Slack.
   7. Which agent app do I use: the Claude desktop app, the Claude Code CLI, Codex, or a different app?

3. **Build the vault.**
   - In the repo folder, run `./install.sh <path>`. `<path>` is the folder that I selected in step 2.
   - The script copies the template and makes the commit hook executable. Then it runs `git init` and makes a first commit with the message `start vault`.
   - The script stops and changes nothing if one of these 3 conditions is true:
     - The folder is not empty.
     - The folder is inside a different git repo.
     - Git has no user name and email.
   - If the script stops, show me its message and ask me what to do. Do not try a different method to get past the stop.

   If you cannot run `install.sh` (for example, on Windows without WSL), do the steps of the script yourself:

   1. Check the same 3 conditions. If one condition is true, stop and tell me.
   2. Copy all files in `vault/` to the folder that I selected. Include the hidden files.
   3. Examine `.claude/skills`. On Windows, git often writes this link as a small text file. If `.claude/skills` is a text file, replace it with a copy of `_skills/`.
   4. If you made that copy, tell me 2 facts. `_skills/` is the folder to edit. After each change to `_skills/`, I must copy it to `.claude/skills/` again.
   5. Run `git init`. Then commit all files with the message `start vault`.
   6. If the commit hook in `.claude/hooks/` cannot run, tell me. The vault works without the hook, because `AGENTS.md` also tells agents to commit.

4. **Customize the vault.**
   1. In `AGENTS.md`, replace the example product list with my products. Delete the comment above the list.
   2. In `AGENTS.md`, fill in the section "About the user" with my answers to questions 2, 4, 6 and 7. Delete the comment in that section.
   3. In `open-actions.md` and `linked-resources.md`, delete the example rows. Keep the markdown headings. In a table, also keep the header row.
   4. In `changelog.md`, delete the example entries and keep the introduction. Add an entry for today with this line: `Created the vault from pm-agent-toolkit, and removed the examples from [[open-actions]] and [[linked-resources]]. Still open: add work notes.`
   5. In `open-actions.md`, `linked-resources.md` and `changelog.md`, set the `date` field to today.
   6. Do not change other files. I will change the folder READMEs later, when I know what I need.
   7. Commit with the message `customize vault`.

5. **Tell me about my company's data policy.** Do this step before step 6, where you add my notes to the vault.
   - Tell me to check my company's policy about which work information I can keep in local files and send to AI tools.
   - Tell me that git keeps each committed file in its history. If I delete the file later, the history still has it.

6. **Add my existing notes.** Do this step only if my answer to question 5 in step 2 was yes.
   1. Ask me to confirm that my company's policy permits these notes in the vault. If I do not confirm, skip this step.
   2. Copy the notes from the location that I gave into `00-inbox/`. Do not move or change the originals.
   3. Run the `process-inbox` skill in `_skills/`.
   4. If you do not know which folder a note goes in, ask me before you move it.

7. **Daily summary.** Do this step only if my answer to question 6 in step 2 was yes.
   - Tell me how to schedule the `daily-note` skill for each weekday morning, in the app that I use. The task must start in `<vault>`.
     - In the Claude desktop app, create a local scheduled task. A local task runs only while the computer is on and awake.
     - In the Claude Code CLI, use the scheduler of the operating system (`cron` or `launchd` on macOS and Linux). The job runs `claude -p "Run the daily-note skill."` in `<vault>`.
     - In a different app, tell me to look in its documentation for scheduled tasks.
   - A headless run cannot ask for permission. Tell me to give the job only the permissions that it needs: edit files in `<vault>`, run `git add` and `git commit`, read the calendar, and send a message to me with the chat tool. For example, use `--allowedTools`. Do not recommend a flag that skips all permission checks.
   - Tell me why the limits are important. The job reads calendar events that other people write. If an event contains instructions, a job with wide permissions can obey them without a person who checks.
   - Tell me to run the command one time by hand before I schedule it.
   - Warning: do not recommend a scheduled task that runs in the cloud. A task in the cloud cannot read the files on my computer.
   - The summary must go only to me.
   - Do not create the scheduled task unless I approve.

8. **Create today's note** with the `daily-note` skill. The skill commits the note. Do not send the summary today. From the next day, `daily-note` sends the summary when it creates the day's note: from the scheduled task if I created one, or else from my first session of the day.

9. **Delete the temporary clone.** If you cloned the repo into a temporary folder, delete that clone. Do not delete a clone that I made.

10. **Connect the vault to code repos.** Do this step only if my answer to question 7 was the Claude desktop app or the Claude Code CLI.
    1. Tell me 2 facts. If I start Claude Code in a code repo and add the vault folder, Claude Code loads the vault skills. It does not read `AGENTS.md`, and the commit hook does not run.
    2. Offer to add this line to `~/.claude/CLAUDE.md`. Replace `<vault>` with the path of the vault.

       ```
       If `<vault>` is an added directory, read `<vault>/AGENTS.md` before you change files in `<vault>`, and obey its rules there.
       ```

    3. Add the line only if I approve. If `~/.claude/CLAUDE.md` does not exist, create it.

11. **Tell me how to use the vault**, in 6 lines or fewer. Use the real path in place of `<vault>`.
    - To work in the vault, start the agent in `<vault>`.
    - To work in a code repo with the vault as context, add `<vault>` to the session. Give me only the method for the app in my answer to question 7:
      - In the Claude desktop app, create a local workspace for the repo and include `<vault>`. Each new session in that workspace then has both folders. For one session only, select + and then Add folder. These desktop features can change.
      - In the Claude Code CLI, use `claude --add-dir <vault>`.
      - For a different agent app, tell me to look in its documentation for a way to add a second folder.
    - Other agents read `AGENTS.md`. Claude Code reads `CLAUDE.md`, which points to `AGENTS.md`.
    - The commit hook runs only in a session that starts in the vault folder.

**Done when:** all 3 of these are true in the vault folder:

- `git log` shows the commits `start vault` and `customize vault`.
- Today's note is in `_daily/`.
- `git status` shows no uncommitted changes.

**Output:** the explanation from step 11.
