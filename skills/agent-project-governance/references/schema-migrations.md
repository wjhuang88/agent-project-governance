# Manifest Schema Migrations

Use this reference when changing `.agent-governance/manifest.yaml` or
`assets/manifest.schema.json`.

## Rules

- Keep `schema_version` as a string.
- Additive fields may keep the current schema version when existing manifests remain valid.
- Rename, removal, meaning changes, or new required fields require a new schema version.
- Preserve old manifest data during adoption; do not rewrite unknown project-specific fields unless
  the migration explicitly owns them.
- Update `assets/manifest.template.yaml`, `assets/manifest.schema.json`, and
  `references/initialization-and-adoption.md` together when the contract changes.
- Keep validators dependency-free. Schema files are editor/documentation aids unless a future
  release explicitly changes the maintenance model.

## Migration Note Format

Record future migrations in the release or project adoption notes:

```markdown
Manifest schema migration:
- from: "1"
- to: "2"
- reason:
- project impact:
- required edits:
- validation:
```
