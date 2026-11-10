# Inbox

Files that are not filed yet: exports, transcripts, screenshots, rough notes and files from other people.

## File names

Keep the original file name until you process the file.

## Front matter

None. Files in this folder are raw.

## Rules for this folder

- Do not edit or rename files in this folder. They are raw sources. Process them with `_skills/process-inbox`, which writes a new note from each file.
- After you process a file, move the original out of this folder:
  - If the new note links to the original (for example an image or a PDF), move the original to `_attachments/`.
  - If not, move the original to `_archive/00-inbox/`. If that folder does not exist, create it.
- Delete an original only if the user approves.
- After processing, the inbox must contain only this README.
- If you do not know which folder a file goes in, ask the user before you move the file.
