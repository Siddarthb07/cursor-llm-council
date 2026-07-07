---
name: llm-council
description: >-
  Run a multi-model LLM council with brutal honesty, mandatory adversarial
  review, pre-flight cost disclosure, budget tiers, and optional supervisor.
  Use when the user says /council, llm council, council review, or wants
  honest multi-AI perspectives. Shows token cost estimate before running.
disable-model-invocation: true
---

# LLM Council

Run an honest multi-model council before building, deciding, or shipping. **Read [chair-checklist.md](chair-checklist.md) and follow it in order.**

## Quick Start

1. Show **Phase -1 pre-flight** (cost, limitations, transcript path) — see [cost-disclaimer.md](cost-disclaimer.md) and [limitations.md](limitations.md)
2. Build context packet; apply sensitive-file blocklist — see [chair-checklist.md](chair-checklist.md)
3. Launch member Tasks **in parallel** — roster from [council-roster.md](council-roster.md)
4. Run quality gate; Red Team if triggered or `deep` mode
5. Launch supervisor (unless `--no-supervisor`)
6. Save transcript (unless `--no-transcript`); present verdict — templates in [output-templates.md](output-templates.md)

## Invocation

**Triggers:** `/council <topic>`, `run llm council`, `council review`, `honest feedback before I build X`

| Flag | Effect |
|------|--------|
| `--tier=budget\|standard\|premium` | Model tier (default: `standard`) |
| `--mode=quick\|standard\|deep` | Deliberation depth (default: `standard`) |
| `--no-supervisor` | Raw member reports only |
| `--no-transcript` | Skip disk write |
| `--plan-only` | Deliberate + plan; no execution |
| `--execute` | Allocate subagents for endorsed work |
| `--members=N` | Override size (clamped by mode) |
| `--config=<path>` | Custom config (v0.2) |

## Phase -1: Pre-Flight (MANDATORY)

**No Task launches before pre-flight is shown.** Use template in [output-templates.md](output-templates.md).

Include: tier, mode, estimated calls, cost level, limitations ack, transcript path, "do not paste secrets."

**Abort:** user says stop/cancel → zero Tasks.

## Phase 0: Setup

Follow [chair-checklist.md](chair-checklist.md) steps 3–7.

**Context packet** (max ~4k tokens):

```markdown
## Context Packet
- **Topic:** ...
- **User goal:** ...
- **Constraints:** ...
- **Relevant files:** (summaries only)
- **Open questions:** ...
```

**Config precedence:** CLI flags > project `.cursor/council.config.yaml` > `~/.cursor/skills/llm-council/council.config.yaml` > [council-roster.md](council-roster.md)

## Phase 1: Independent Review

**Charter embedding (critical):** Before launching Tasks, `Read` `honesty-charter.md` from the installed skill path. Paste the **entire file contents** into every member and supervisor prompt — all sections including Banned Phrases, Verdict Definitions, Member Obligations, and Supervisor Extra Duty. **Never summarize or compress.** A paraphrased charter voids the honesty guarantee (verified failure mode in live testing).

Launch **one Task per member in a single message**. Each Task:

```text
subagent_type: generalPurpose
model: <from council-roster for tier>
readonly: true
run_in_background: false
description: "Council <RoleName>"
prompt: |
  <FULL CONTENTS of honesty-charter.md — every line, no omissions>

  <FULL BODY of agents/council-<role>.md — below frontmatter>

  TOPIC: ...
  CONTEXT PACKET: ...

  Output using Member Report template in output-templates.md.
  Work independently. You cannot see other members.
```

**DevilsAdvocate is mandatory** in `standard` and `deep` modes.

**Persona files** live in `~/.cursor/agents/council-*.md` after install.

### Failure handling

See [failure-recovery.md](failure-recovery.md): retry once, try fallback model, note partial council, never fabricate missing opinions.

## Phase 1b: Quality Gate

Scan member reports. **Trigger Red Team** if ANY:

| Signal | Threshold |
|--------|-----------|
| Unanimous ADOPT | All members ADOPT |
| Thin flaws | Any member has fewer than 2 flaws |
| Hollow praise | Banned phrase without evidence (see honesty-charter) |
| No dissent | Zero REVISE/REJECT on non-trivial topic (4+ members) |
| Verdict mismatch | ADOPT but summary mostly negative |

**Red Team:** additional Task, DevilsAdvocate persona, strongest model for tier. Prompt: *"The council may be too agreeable. Kill this idea or force major revision. Assume it fails."*

**Deep mode:** Red Team always runs (not just on gate).

Show banner: `Council was flagged as too agreeable` when gate-triggered.

## Phase 2: Supervisor

Unless `--no-supervisor`, launch one supervisor Task with all reports + red team (if any).

Embed [honesty-charter.md](honesty-charter.md) verbatim. Use [council-supervisor.md](../agents/council-supervisor.md) persona.

Output: scoring matrix + supervisor verdict per [output-templates.md](output-templates.md).

**Skepticism upgrade:** if ≥3 ADOPT with thin flaws, supervisor must harden critique.

## Phase 3: Transcript + Plan + Execute

1. **Transcript:** save to `.cursor/council-sessions/{ISO}-{slug}.md` unless `--no-transcript`
2. **Plan:** if requested, from supervisor verdict only — never plan rejected ideas
3. **Execute** (`--execute`): map endorsed items to subagents:

| Work | subagent_type |
|------|---------------|
| Exploration | `explore` |
| Implementation | `generalPurpose` |
| Shell/git/CI | `shell` |
| Security | `security-review` |
| Bugs | `bugbot` |

**Never execute items on supervisor "Do not do" list.**

## Honesty System

1. **Charter** — verbatim in every prompt ([honesty-charter.md](honesty-charter.md))
2. **Mandatory DevilsAdvocate** — standard + deep
3. **Quality gate + Red Team**
4. **Supervisor skepticism upgrade**
5. **Documented limits** — [limitations.md](limitations.md)

## Sensitive Files

Exclude from context: `.env`, `.env.*`, `*credentials*`, `*secret*`, `*.pem`, `*.key`, `id_rsa*`, `.aws/**`, `serviceAccountKey.json`

## Additional Resources

- [examples.md](examples.md) — invocation patterns
- [cost-disclaimer.md](cost-disclaimer.md) — token costs
- [limitations.md](limitations.md) — what is not guaranteed
- [chair-checklist.md](chair-checklist.md) — mechanical steps
- [council-roster.md](council-roster.md) — models and modes
- [failure-recovery.md](failure-recovery.md) — retries and fallbacks
