# Templates

Templates for new notes. To make a new note, copy a template. Do not edit a template unless the user asks.

| Template | Used for |
|---|---|
| `daily-note.md` | Today's note in `_daily/` |
| `meeting-note.md` | Meetings in `05-meetings/` |
| `person.md` | People in `11-people/` |
| `prd.md` | Briefs and PRDs in `03-prds/` |
| `project.md` | Projects in `13-projects/` |
| `customer-feedback.md` | Feedback in `04-customer-feedback/` |
| `goals.md` | `12-career/goals.md` |

In a template, `{{date}}` means today's date as `YYYY-MM-DD`. `{{title}}` means the title of the note.

In front matter, `a | b` lists the permitted values. Replace the list with one value, for example `source: call`. Do not keep the `|`.
