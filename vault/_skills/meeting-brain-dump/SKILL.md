---
name: meeting-brain-dump
description: Ask the user questions right after a meeting with no transcript, then write the meeting note. Use when the user says they want to do a brain dump.
---

# meeting-brain-dump

1. Ask the user these 5 questions, one at a time:
   1. Who attended?
   2. What was the meeting about?
   3. What did the group decide?
   4. What did each person agree to do?
   5. What surprised you?
2. Accept loose answers. Do not make the user complete a form.
3. If an answer is not clear, ask 1 follow-up question about it. For example, ask about an action that has no owner.
4. Write the note from `_templates/meeting-note.md`. Set `source: brain dump`.
5. Do steps 5 to 8 of `meeting-from-transcript`.
