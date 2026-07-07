# cursor-llm-council

Multi-model AI council for [Cursor](https://cursor.com) that **won't yes-man your bad ideas**.

Independent reviewers on different models. Mandatory devil's advocate. Pre-flight cost disclosure. Optional supervisor synthesis. Session transcripts.

> **Honesty is prompt-enforced, not guaranteed.** See [limitations](skill/limitations.md).

---

## Token / Cost Disclaimer

**Every council session uses multiple model invocations billed to your Cursor plan.** No calls are made until pre-flight is shown.

| Mode | Members | Supervisor | Red Team | Approx. calls | Relative cost |
|------|---------|------------|----------|---------------|---------------|
| `quick` | 2 | off | no | **2** | Low |
| `standard` | 4 | yes | if triggered | **5–6** | Medium |
| `deep` | 5 | yes | always | **7** | High |

| Tier | Models | Relative cost per call |
|------|--------|------------------------|
| `budget` | gemini-3-flash, gpt-5-mini, composer-2.5-fast | **Lowest** |
| `standard` (default) | opus/sonnet, gemini-3.1-pro, gpt-5.4-medium | **Medium** |
| `premium` | opus/high-thinking across roles | **Highest** |

- Thinking models cost more than fast models.
- `--tier=budget --mode=quick` = cheapest (~2 calls).
- `--tier=premium --mode=deep` = most expensive (~7 calls, premium models).

Full detail: [skill/cost-disclaimer.md](skill/cost-disclaimer.md)

---

## Install

### Windows

```powershell
git clone https://github.com/Siddarthb07/cursor-llm-council.git
cd cursor-llm-council
.\install.ps1
```

### macOS / Linux

```bash
git clone https://github.com/Siddarthb07/cursor-llm-council.git
cd cursor-llm-council
chmod +x install.sh
./install.sh
```

Add `--force` to overwrite an existing install.

### What gets installed

| Source | Destination |
|--------|---------------|
| `skill/` | `~/.cursor/skills/llm-council/` |
| `agents/council-*.md` | `~/.cursor/agents/` |

---

## Quick Start

In Cursor chat:

```
/council Should I rewrite my entire backend in Rust?
```

```
/council --tier=budget --mode=quick Is this API naming clear?
```

```
/council --tier=premium --mode=deep Should we split into microservices?
```

The agent shows **pre-flight** (cost, limitations, transcript path) before launching any model calls.

---

## Flags

| Flag | Effect |
|------|--------|
| `--tier=budget\|standard\|premium` | Model cost/depth tier |
| `--mode=quick\|standard\|deep` | Deliberation depth |
| `--no-supervisor` | Raw member reports only |
| `--no-transcript` | Skip saving session to disk |
| `--plan-only` | Deliberate + plan, no execution |
| `--execute` | Run subagents for endorsed work |

More: [skill/examples.md](skill/examples.md)

---

## How It Works

1. **Pre-flight** — cost estimate, limitations, transcript warning
2. **Parallel review** — 2–5 members on different models, isolated
3. **Devil's advocate** — mandatory in standard/deep modes
4. **Quality gate** — detects rubber-stamping; triggers red team if needed
5. **Supervisor** — weighted scoring, verdict, "do not do" list
6. **Transcript** — saved to `.cursor/council-sessions/` (unless opted out)

See [docs/architecture.md](docs/architecture.md).

---

## Sample Output

A full REJECT session on a bad idea: [docs/sample-transcript.md](docs/sample-transcript.md)

Live publish-readiness council test: [docs/live-session-publish-readiness.md](docs/live-session-publish-readiness.md)

**Verify your install:** [docs/test-prompts.md](docs/test-prompts.md)

---

## Security / Privacy

- Chair excludes `.env`, credentials, keys from context (blocklist).
- **Do not paste secrets** into council topics.
- Add to `.gitignore`:

```
.cursor/council-sessions/
```

- Use `--no-transcript` for sensitive deliberations.

---

## Limitations

- Prompts guide honesty; models may still agree too readily.
- Different models ≠ guaranteed different conclusions.
- Council advises; **you** decide.

Full list: [skill/limitations.md](skill/limitations.md)

---

## Uninstall

```bash
./uninstall.sh        # macOS/Linux
.\uninstall.ps1       # Windows
```

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Changes to [honesty-charter.md](skill/honesty-charter.md) require extra review.

---

## License

MIT — see [LICENSE](LICENSE)
