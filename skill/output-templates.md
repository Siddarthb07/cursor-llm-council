# Output Templates

## Phase -1 Pre-Flight (chair presents to user)

```markdown
## Council Pre-Flight

**Tier:** <budget|standard|premium>
**Mode:** <quick|standard|deep>
**Estimated model calls:** <N> members + <0|1> supervisor [+ <0|1> red team]
**Estimated cost:** See cost-disclaimer.md — <low|medium|high> relative bill

### Limitations
- Honesty is **prompt-enforced**, not deterministic.
- Different models ≠ guaranteed different conclusions.
- Council advises; **you** decide.
- Do **not** paste secrets, API keys, or credentials into the topic.

### Transcript
- Saved to: `.cursor/council-sessions/<timestamp>-<slug>.md` (unless `--no-transcript`)
- Add `.cursor/council-sessions/` to `.gitignore`

Proceeding with council...
```

## Member Report

Each member outputs exactly this structure:

```markdown
## <RoleName> — <model>

**Verdict:** ADOPT | REVISE | REJECT
**Confidence:** high | medium | low

### Summary
(2-3 sentences, zero fluff)

### Strengths
(max 3, each with evidence)

1. ...

### Flaws (min 2, mandatory)
1. ...
2. ...

### Risks if we proceed anyway

### Conditions that would change my verdict
```

## Red Team Report

```markdown
## Red Team — <model>

**Verdict:** ADOPT | REVISE | REJECT
**Trigger:** quality-gate | deep-mode-mandatory

### Why this idea should fail

### Strongest kill shot

### Minimum changes to survive
```

## Supervisor Scoring Matrix

```markdown
| Dimension       | Score (1-10) | Key driver |
|-----------------|--------------|------------|
| Feasibility     |              |            |
| Security        |              |            |
| Value           |              |            |
| Maintainability |              |            |
| Cost            |              |            |
| **Weighted**    |              |            |
```

Weights (default): feasibility 0.25, security 0.25, value 0.20, maintainability 0.15, cost 0.15.

## Supervisor Verdict

```markdown
## Council Verdict

**Idea rating:** STRONG | VIABLE_WITH_CHANGES | WEAK | REJECT
**Recommended path:** ...
**Do not do:**
- ...
**Dissent:** (who disagreed with whom and why)
**Agreeableness audit:** pass | flagged | red-team-triggered
**Confidence:** high | medium | low
```

## Session Transcript (saved to disk)

```markdown
# Council Session: <topic>

**Date:** <ISO-8601>
**Tier:** <tier> | **Mode:** <mode> | **Supervisor:** on|off
**Quality gate:** pass | red-team-triggered
**Partial council:** no | yes (<missing members>)

## Config Snapshot
(tier, mode, flags, models used)

## Context Packet
...

## Member Reports
...

## Red Team Report
(if any)

## Supervisor Verdict
...

## Plan
(if generated)
```

## No-Supervisor Summary Table

When `--no-supervisor`:

```markdown
| Member | Verdict | Confidence | Top flaw |
|--------|---------|------------|----------|
| ...    | ...     | ...        | ...      |

**Verdict counts:** ADOPT: N | REVISE: N | REJECT: N
```
