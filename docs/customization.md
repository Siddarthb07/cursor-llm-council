# Customization

## Install locations

| Scope | Skill | Agents | Config |
|-------|-------|--------|--------|
| User (default) | `~/.cursor/skills/llm-council/` | `~/.cursor/agents/` | `~/.cursor/skills/llm-council/council.config.yaml` |
| Project override | — | — | `.cursor/council.config.yaml` |

**Config precedence:** CLI flags > project config > user config > `council-roster.md` defaults.

## Model tiers

Set default in config or per invocation:

```
/council --tier=budget Is this worth building?
/council --tier=premium --mode=deep Should we re-architect auth?
```

Edit `tiers` in `council.config.yaml` to swap models for your account.

## Deliberation modes

See [deliberation-modes.md](deliberation-modes.md).

## Scoring weights

Supervisor weighted matrix uses `scoring_weights` from config. Defaults:

- feasibility: 0.25
- security: 0.25
- value: 0.20
- maintainability: 0.15
- cost: 0.15

## Sensitive file blocklist

Extend `sensitive_file_blocklist` in config. Chair excludes matching paths from context packets.

## Project-level vendoring

Teams can submodule the repo:

```bash
git submodule add https://github.com/Siddarthb07/cursor-llm-council .cursor/llm-council
```

Then symlink or run install pointing at the submodule. Document the path in your team README.

## Dual install conflict

If both user-level and project-level config exist, project wins for config only. Skill and agents remain user-level unless you copy manually. Prefer one install path per team to avoid persona drift.

## Validating config

v0.2 includes `skill/config.schema.json`. Validate YAML with any JSON Schema tool after converting YAML to JSON, or rely on chair fallback to defaults on parse errors.

## Adding a persona

See [CONTRIBUTING.md](../CONTRIBUTING.md).
