# Examples

## Basic invocation

```
/council Should I rewrite my entire backend in Rust?
```

Chair shows pre-flight, runs standard tier, 4 members + supervisor, presents verdict.

## Budget quick gut-check

```
/council --tier=budget --mode=quick Is this variable name clear enough?
```

2 members (DevilsAdvocate + Pragmatist), no supervisor, low cost.

## Deep architecture review

```
/council --tier=premium --mode=deep Should we migrate from monolith to microservices?
```

5 members + supervisor + mandatory red team, highest cost.

## Skip supervisor

```
/council --no-supervisor Review this API design for obvious flaws
```

Raw member reports and verdict count table only.

## No transcript (sensitive topic)

```
/council --no-transcript Is our auth architecture sound for multi-tenant SaaS?
```

Council runs but nothing written to `.cursor/council-sessions/`.

## Plan only

```
/council --plan-only Should we add Redis caching to the read path?
```

Deliberation + structured plan; no `--execute` subagents.

## Execute after council

```
/council --execute Build the caching layer the council endorsed
```

Only proceeds with supervisor-endorsed items; skips "Do not do" list.

## Review a plan file

```
/council Review the plan at .cursor/plans/my-feature.plan.md
```

Chair reads the plan into context packet, then runs council.

## Cancel before launch

User: `/council ...`  
Chair: shows pre-flight  
User: `stop`  
Chair: launches zero Tasks.

## Expected behavior on a bad idea

Topic: "Store all user passwords in localStorage for convenience"

- DevilsAdvocate: **REJECT**
- SecuritySkeptic: **REJECT**
- At least 2 flaws per member citing XSS, device theft, no httpOnly protection
- Supervisor: **REJECT**, "Do not do: client-side password storage"

See [sample-transcript.md](../docs/sample-transcript.md) for a full example.
