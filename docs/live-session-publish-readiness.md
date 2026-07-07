# Council Session: Is cursor-llm-council ready to publish to GitHub?

**Date:** 2026-07-07T21:30:00+05:30
**Tier:** standard | **Mode:** standard | **Supervisor:** on
**Quality gate:** pass (unanimous REVISE — no red team)
**Partial council:** no
**Trigger:** User test — "run the skill on my claude to test"

## Config Snapshot

- Tier: standard
- Mode: standard
- Members: DevilsAdvocate (claude-opus-4-8-thinking-high), Architect (gemini-3.1-pro), Pragmatist (gpt-5.4-medium), SecuritySkeptic (claude-sonnet-5-thinking-high)
- Supervisor: claude-4.6-opus-high-thinking

## Context Packet

- **Topic:** Publish cursor-llm-council to GitHub as open source
- **User goal:** Live test of the llm-council skill
- **State:** Repo built, installed to ~/.cursor/skills, static verification passed
- **Gaps:** No git commit, YOUR_USERNAME placeholder in README

## Member Verdicts

| Member | Model | Verdict | Confidence |
|--------|-------|---------|------------|
| DevilsAdvocate | claude-opus-4-8-thinking-high | REVISE | high |
| Architect | gemini-3.1-pro | REVISE | high |
| Pragmatist | gpt-5.4-medium | REVISE | high |
| SecuritySkeptic | claude-sonnet-5-thinking-high | REVISE | high |

## Supervisor Verdict

**Idea rating:** VIABLE_WITH_CHANGES

### Scoring Matrix

| Dimension | Score | Weight | Weighted |
|-----------|-------|--------|----------|
| Feasibility | 8 | 0.25 | 2.00 |
| Security | 5 | 0.25 | 1.25 |
| Value | 8 | 0.20 | 1.60 |
| Maintainability | 5 | 0.15 | 0.75 |
| Cost | 7 | 0.15 | 1.05 |
| **Total** | | | **6.65** |

**Recommended path:** 30–60 minute cleanup pass, one real logged E2E council run, initial git commit + tag v0.1.0, then publish.

**Do not do:**
- Publish with YOUR_USERNAME placeholder in clone URLs
- Claim deterministic honesty — charter was paraphrased on first live test
- Ship without at least one logged real multi-model session transcript
- Run uninstall without backing up council.config.yaml
- Ignore council-* agent name collision with Cursor built-in subagent types

**Agreeableness audit:** pass — all 4 members REVISE with substantive flaws

**Confidence:** high

## Meta: Skill Test Result

**The council skill works.** Parallel Claude + Gemini + GPT members ran independently, DevilsAdvocate caught chair charter drift, no rubber-stamping.

**Chair self-correction needed:** Embed honesty-charter.md verbatim in future Task prompts (full file, not summarized).
