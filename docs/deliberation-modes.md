# Deliberation Modes

Choose depth vs. cost. All modes show pre-flight before launching Tasks.

## Comparison

| Mode | Members | DevilsAdvocate | Supervisor | Red Team | Approx. calls | Best for |
|------|---------|----------------|------------|----------|---------------|----------|
| `quick` | 2 | mandatory (1 slot) | off | no | 2 | Naming, small refactors, low stakes |
| `standard` | 4 | mandatory | on | if gate | 5–6 | Most decisions (default) |
| `deep` | 5 | mandatory | on | always | 7 | Architecture, security, business bets |

Combine with `--tier`:

| Combination | Cost | Depth |
|-------------|------|-------|
| `quick` + `budget` | Lowest | Lightest |
| `standard` + `standard` | Medium | Recommended |
| `deep` + `premium` | Highest | Strongest |

## quick

**Roster:** DevilsAdvocate + Pragmatist

- No supervisor by default (add `--no-supervisor` is redundant)
- No quality gate red team
- Fast and cheap
- **Warning:** insufficient for security or architecture decisions

```
/council --mode=quick --tier=budget Should I rename this function?
```

## standard (default)

**Roster:** DevilsAdvocate, Architect, Pragmatist, SecuritySkeptic

- Supervisor on (unless `--no-supervisor`)
- Quality gate may trigger Red Team
- Balanced cost and critique

```
/council Should we add Redis caching?
```

## deep

**Roster:** standard four + ProductRealist

- Red Team **always** runs (in addition to mandatory DevilsAdvocate)
- Highest call count in the mode
- Use for irreversible or expensive decisions

```
/council --mode=deep --tier=premium Should we migrate to microservices?
```

## Overrides

`--members=N` adjusts size within mode limits (2–5). Chair clamps to mode minimums. DevilsAdvocate cannot be removed in standard/deep.

## When not to use the council

- Trivial syntax questions — just ask the agent
- Time-critical production incidents — fix first, postmortem later
- Decisions requiring legal/compliance sign-off — council informs, does not certify
