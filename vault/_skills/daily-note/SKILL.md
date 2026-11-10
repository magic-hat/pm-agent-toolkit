---
name: daily-note
description: Create today's daily note from the vault's open actions, calendar and recent notes. Use at the start of the first session of the day, or when the user asks for a daily rundown.
---

# daily-note

1. Look for `_daily/YYYY-MM-DD.md` for today. If the note exists, read it and stop. Continue only if the user asked for a refresh.
2. Copy `_templates/daily-note.md` to `_daily/YYYY-MM-DD.md`.
3. If a calendar tool is connected, list today's meetings under **Meetings today**. For each meeting, write if a prep note or a person note exists.
4. Read `open-actions.md`. Copy each action that is due today or overdue into **Due or overdue**.
5. Under **Prep needed**, list each meeting that is related to an open action, or to a project that changed in the last 7 days.
6. Read the 2 most recent daily notes before today. Copy each item under **End of day** that moved to tomorrow into **Focus**.
7. Read **Daily summary** in the section "About the user" in `AGENTS.md`. If the value is yes, send a short version of the note to the place that the value gives: meetings, prep and due actions. If the value is no, or the chat tool is not connected, do not send a summary. During setup from `SETUP_PROMPT.md`, do not send a summary.
8. Send the summary only to the user. Do not send it to other people.
9. Add a bullet to today's entry in `changelog.md`. Then commit the new note.
