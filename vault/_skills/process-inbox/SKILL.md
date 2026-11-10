---
name: process-inbox
description: File everything in 00-inbox into the right folder with front matter. Use when the user drops files in the inbox or asks to process it.
---

# process-inbox

1. List the files in `00-inbox/`. Do not include `README.md`.
2. For each file, find the folder that it belongs in. Use the `README.md` of each folder.
3. If you do not know the folder, ask the user. Do not move the file until the user answers.
4. If you know the folder, write a new note from the file. Do not edit the original file.
   1. Create the note in the folder. Use the naming rule and the template of the folder.
   2. Write the content of the file into the note, in markdown. Do not invent content. If the template asks for information that the original does not have, write `TBD`.
   3. Add the 7 front matter fields from `AGENTS.md`. Use the values in the `README.md` of the folder. Set `source` to the type of the original, for example `transcript`, `notes` or `ticket`. Use a value that the README of the folder permits.
   4. If the file is a meeting transcript or meeting notes, also do steps 3 to 6 of `_skills/meeting-from-transcript`. These steps record the actions and update the notes in `11-people/`.
   5. Move the original out of `00-inbox/`. If the note links to the original (for example an image or a PDF), move it to `_attachments/`. If not, move it to `_archive/00-inbox/`. If that folder does not exist, create it.
5. Add each action that you find to `open-actions.md`, if it is not already there.
6. Tell the user where each file went.
7. Add a bullet to today's entry in `changelog.md`. Then commit.
