# Council Roster

Default members, models, and selection rules. Override via `--tier` flag or `council.config.yaml` (v0.2).

## Model Tiers

### Budget (`--tier=budget`)

| Role | Model | Fallback |
|------|-------|----------|
| DevilsAdvocate | gemini-3-flash | gpt-5-mini |
| Architect | gpt-5-mini | gemini-3-flash |
| Pragmatist | composer-2.5-fast | gpt-5-mini |
| SecuritySkeptic | gemini-3-flash | gpt-5-mini |
| Supervisor | gpt-5.4-medium | gpt-5.2 |

### Standard (`--tier=standard`, default)

| Role | Model | Fallback |
|------|-------|----------|
| DevilsAdvocate | claude-opus-4-8-thinking-high | claude-4.6-opus-high-thinking |
| Architect | gemini-3.1-pro | gemini-3.5-flash |
| Pragmatist | gpt-5.4-medium | gpt-5.2 |
| SecuritySkeptic | claude-sonnet-5-thinking-high | gpt-5.4-medium |
| Supervisor | claude-4.6-opus-high-thinking | claude-opus-4-8-thinking-high |
| Red Team | claude-opus-4-8-thinking-high | claude-4.6-opus-high-thinking |

### Premium (`--tier=premium`)

| Role | Model | Fallback |
|------|-------|----------|
| DevilsAdvocate | claude-opus-4-8-thinking-high | claude-opus-4-7-thinking-xhigh |
| Architect | gemini-3.1-pro | claude-sonnet-5-thinking-high |
| Pragmatist | gpt-5.5-medium | gpt-5.4-medium |
| SecuritySkeptic | claude-4.6-opus-high-thinking | claude-sonnet-5-thinking-high |
| Supervisor | claude-opus-4-8-thinking-high | claude-4.6-opus-high-thinking |
| Red Team | claude-opus-4-8-thinking-high | claude-opus-4-7-thinking-xhigh |

## Deliberation Modes

| Mode | Members | DevilsAdvocate | Supervisor | Red Team |
|------|---------|----------------|------------|----------|
| `quick` | 2 | 1 of 2 slots | off | no |
| `standard` | 4 | **always** | on | if quality gate |
| `deep` | 5 | **always** | on | **always** |

Default mode: `standard`.

### Standard mode roster (4 members)

1. DevilsAdvocate (mandatory)
2. Architect
3. Pragmatist
4. SecuritySkeptic

### Deep mode roster (5 members)

Standard four + **ProductRealist** (`grok-4.3`, fallback `gpt-5.4-medium`)

### Quick mode roster (2 members)

1. DevilsAdvocate (mandatory)
2. Pragmatist

## Topic-Based Swaps

Chair may swap one member based on topic:

| Topic | Swap |
|-------|------|
| Code review | Replace Pragmatist with `bugbot` or `security-review` subagent_type |
| Research / exploration | Replace Architect with `explore` subagent on gemini-3-flash |
| Product / UX | In deep mode ProductRealist already included; in standard swap Pragmatist → ProductRealist |

## Red Team

- **Triggered** in standard mode when quality gate fires (see SKILL.md).
- **Mandatory** in deep mode.
- Uses DevilsAdvocate persona on Red Team model for tier.
- Prompt: *"The council may be too agreeable. Kill this idea or force major revision. Assume it fails."*

## Partial Council

If a member Task fails after one retry, proceed with available reports. Note missing member in transcript. Never invent their opinion.
