# Architecture

How the LLM council works inside Cursor.

## Components

| Component | Location | Role |
|-----------|----------|------|
| Skill | `~/.cursor/skills/llm-council/` | Orchestration instructions for the chair agent |
| Personas | `~/.cursor/agents/council-*.md` | Role prompts embedded in Task calls |
| Config | `council.config.yaml` | Model tiers, weights, blocklist (optional) |
| Transcripts | `.cursor/council-sessions/` | Audit trail per session |

## Flow

```
User invokes /council
        │
        ▼
Chair (main agent) reads SKILL.md
        │
        ▼
Phase -1: Pre-flight (cost, limitations) ──► user can abort
        │
        ▼
Phase 0: Context packet + roster selection
        │
        ▼
Phase 1: Parallel Task subagents (generalPurpose, different models)
        │   Each gets honesty-charter verbatim + persona
        ▼
Phase 1b: Quality gate ──► Red Team if triggered (or always in deep)
        │
        ▼
Phase 2: Supervisor Task synthesizes
        │
        ▼
Phase 3: Transcript + optional plan + optional execute
```

## Why Task tool, not SDK

- Zero dependencies — works in any Cursor session with subagent support
- Uses the user's existing models and plan
- No API keys or external orchestrator
- Trade-off: enforcement is prompt-based, not mechanical

## Isolation model

Members do not see each other's output. Only the chair and supervisor see all reports. This prevents bandwagoning within a single session.

## Honesty layers

1. Charter in every prompt
2. Mandatory DevilsAdvocate (standard/deep)
3. Quality gate heuristics
4. Red Team escalation
5. Supervisor skepticism upgrade
6. Documented limitations (`limitations.md`)

## Epistemic limits

Different models on the same context often agree — especially on obvious good/bad ideas. The council improves critique quality; it does not guarantee diverse conclusions. Role diversity (security vs. pragmatist) matters as much as model diversity.

## Extension points

- New personas in `agents/`
- Custom tiers in config
- Project-level `.cursor/council.config.yaml`
- Future: Cursor hooks for logging `subagentStart` events

## Name collision with Cursor built-ins

Cursor may ship built-in subagent types named `council-devils-advocate`, `council-architect`, `council-supervisor`, etc. This repo also installs `agents/council-*.md` into `~/.cursor/agents/`.

**How this skill uses them:** The chair `Read`s persona files and embeds their bodies into `generalPurpose` Task prompts. It does not invoke built-in subagent types by name.

**Risk:** Confusion about which definition is active. **Mitigation:** Persona files are prompt libraries; the skill SKILL.md orchestration is authoritative. Do not edit built-in subagent definitions expecting this skill to pick them up automatically.
