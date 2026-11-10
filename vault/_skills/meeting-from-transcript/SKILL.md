---
name: meeting-from-transcript
description: Turn a meeting transcript into a meeting note, pull out actions and update people notes. Use when the user pastes a transcript or drops one in the inbox.
---

# meeting-from-transcript

1. Read the transcript. Find the attendees and the purpose of the meeting.
2. Create `05-meetings/YYYY-MM-DD <meeting name>.md` from `_templates/meeting-note.md`. Set `source: transcript`.
3. Write **Decisions** and **Actions** first. Give each action an owner. Add a due date only if a person in the meeting said one.
4. Write a short **Summary**. List the **Open questions**.
5. Add each action to `open-actions.md`, with a link to the meeting note.
6. For each attendee, add a dated line to the note for that person in `11-people/`. If the note does not exist, create it from `_templates/person.md`. If you do not know the role of the person, ask the user.
7. If the transcript is in `00-inbox/`, move it to `_archive/00-inbox/`. Do not edit the transcript. If the folder does not exist, create it.
8. Show the user the actions that you recorded. Add a bullet to today's entry in `changelog.md`. Then commit.
