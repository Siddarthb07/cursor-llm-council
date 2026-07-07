# Token and Cost Disclaimer

**Every council session consumes multiple model invocations.** Costs depend on your Cursor plan, model tier, and deliberation mode.

## Pre-Flight Rule

**No council member or supervisor Task is launched until Phase -1 pre-flight is shown to the user.** Invoking `/council` implies consent to proceed after reading the estimate.

## Calls Per Session

| Mode | Members | Supervisor | Red Team | Approx. total calls |
|------|---------|------------|----------|---------------------|
| `quick` | 2 | off (default) | no | **2** |
| `standard` | 4 | yes | if quality gate triggers | **5–6** |
| `deep` | 5 | yes | always | **7** |

Add **+1** if the agreeableness quality gate triggers a Red Team round in `standard` mode.

## Tier Cost Profile

| Tier | Models used | Relative cost per call | Critique depth |
|------|-------------|------------------------|----------------|
| `budget` | gemini-3-flash, gpt-5-mini, composer-2.5-fast | **Low** | Faster, less adversarial depth |
| `standard` | opus/sonnet, gemini-3.1-pro, gpt-5.4-medium | **Medium** | Recommended default |
| `premium` | opus/high-thinking across most roles | **High** | Strongest critique, highest bill |

Within the same mode, `premium` tier does not add extra calls — it uses more expensive models for the same number of invocations.

## Billing Notes

- Each member, supervisor, and red-team round is a **separate model invocation**.
- Thinking/reasoning models typically cost more than fast models.
- Failed calls that are retried once may add an extra invocation (see `failure-recovery.md`).
- Partial councils (some members failed) still bill for successful calls.

## Cost Control Flags

| Flag | Effect |
|------|--------|
| `--tier=budget` | Cheapest models |
| `--mode=quick` | Fewest calls (2) |
| `--no-supervisor` | Saves 1 call |
| `--no-transcript` | No disk write (does not reduce model calls) |

## Example Estimates (illustrative, not exact)

| Session | Tier | Mode | Calls | Relative bill |
|---------|------|------|-------|---------------|
| Gut-check | budget | quick | 2 | $ |
| Normal review | standard | standard | 5 | $$ |
| Architecture bet | premium | deep | 7 | $$$$ |

Exact pricing is determined by Cursor — check your plan dashboard. This skill does not track or cap spend.

## Recommendation

- **Low stakes / brainstorming:** `--tier=budget --mode=quick`
- **Most decisions:** `--tier=standard` (default)
- **Security, architecture, large bets:** `--tier=premium --mode=deep`
