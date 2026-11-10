# Dashboards

Optional. If the user opens the vault in Obsidian with the Dataview plugin, notes in this folder can show live tables. This example shows each PRD that is in review:

```dataview
TABLE owner, product, date
FROM "03-prds"
WHERE status = "in review"
SORT date DESC
```

If the user does not use Obsidian, answer the same question from the front matter of the notes.
