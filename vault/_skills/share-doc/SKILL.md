---
name: share-doc
description: Publish a vault note as a shared doc and record the link. Use when the user wants to share a note with someone outside the vault.
---

# share-doc

1. Ask the user which note to share, and with whom.
2. If a docs tool is connected (for example Google Docs), create the doc from the content of the note. If no docs tool is connected, tell the user how to create the doc manually.
3. Add a row to `linked-resources.md`: the title, the external link, a one-line description, the local file path and today's date.
4. Sync goes in one direction only: from the vault to the shared doc. Do not copy edits from the shared doc into the vault.
5. If the user asks you to update the shared doc, ask the user if other people edited the shared doc since the last push. Tell the user that a push replaces those edits.
6. Push the vault version only after the user confirms. Then change the date in the row.
7. If the user wants to keep edits from the shared doc, the user must add them to the vault note before the push.
8. Add a bullet to today's entry in `changelog.md`. Then commit.
