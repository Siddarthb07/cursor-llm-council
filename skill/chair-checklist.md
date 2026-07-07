# Chair Checklist

The chair (main Cursor agent invoking this skill) follows these steps **in order**. Do not skip steps. Do not launch council Tasks before Step 1 is complete.

## Phase -1: Pre-Flight

- [ ] **1. Show pre-flight block** to the user before any Task launches:
  - Tier (`budget` | `standard` | `premium`) and mode (`quick` | `standard` | `deep`)
  - Estimated model calls (from `cost-disclaimer.md`)
  - Link to limitations: honesty is prompt-enforced, not guaranteed
  - Transcript path (`.cursor/council-sessions/`) unless `--no-transcript`
  - Reminder: do not paste secrets into the topic
- [ ] **2. Abort if user says** stop / cancel before Phase 1 — launch zero Tasks.

## Phase 0: Setup

- [ ] **3. Parse flags:** `--tier`, `--mode`, `--no-supervisor`, `--no-transcript`, `--plan-only`, `--execute`, `--members=N`, `--config=`
- [ ] **4. Load config** if `--config=` or project `.cursor/council.config.yaml` exists (v0.2); else use `council-roster.md` defaults
- [ ] **5. Build context packet** — summarize topic, goal, constraints, relevant files. **Do not include** blocklisted files (see below).
- [ ] **6. Select roster** from `council-roster.md` for tier + mode. DevilsAdvocate is **mandatory** in `standard` and `deep`.
- [ ] **7. Announce** to user: members, models, supervisor on/off, transcript path.

## Phase 1: Independent Review

- [ ] **8. `Read` `honesty-charter.md` from disk** and each selected persona file from `agents/`. Paste **entire charter file** (all sections) into every Task prompt.
- [ ] **9. Launch all member Tasks in one parallel message** — one Task per member.
- [ ] **10. Verify charter is complete** — Banned Phrases, Verdict Definitions, Member Obligations, Supervisor Extra Duty must all be present. Never summarize.
- [ ] **11. Wait for all Tasks** — retry failed member once; if still failing, note partial council in transcript.
- [ ] **12. Never fabricate** a missing member's opinion.

## Phase 1b: Quality Gate

- [ ] **13. Scan member reports** for agreeableness signals (see SKILL.md quality gate table).
- [ ] **14. Red Team** if gate triggers, or **always** in `deep` mode.
- [ ] **15. Show banner** `Council was flagged as too agreeable` if Red Team triggered by gate.

## Phase 2: Supervisor

- [ ] **16. Launch supervisor** unless `--no-supervisor`.
- [ ] **17. Include** all member reports + red team report (if any) + scoring weights.
- [ ] **18. Supervisor embeds** honesty charter verbatim.

## Phase 3: Output

- [ ] **19. Save transcript** to `.cursor/council-sessions/{ISO-timestamp}-{slug}.md` unless `--no-transcript`.
- [ ] **20. Present verdict** using output templates.
- [ ] **21. Plan** only if user requests and verdict allows — never plan around REJECT items.
- [ ] **22. Execute** (`--execute`) only for supervisor-endorsed items; never build "Do not do" list items.

## Sensitive-File Blocklist

Exclude from context packet (never read contents into prompts):

```
.env, .env.*, **/*credentials*, **/*secret*, **/*.pem, **/*.key,
**/id_rsa*, **/.aws/**, **/serviceAccountKey.json
```

If the topic is secrets architecture, describe patterns only (e.g. "uses env var AUTH_SECRET"), never values.

## Anti-Drift Rules

1. **Never paraphrase** the honesty charter — always copy from `honesty-charter.md`.
2. **Never show** one member's report to another member before supervisor phase.
3. **Never skip** pre-flight to save time.
4. **Never claim** the council guarantees correctness or honesty.
