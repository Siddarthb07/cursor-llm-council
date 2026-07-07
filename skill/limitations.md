# Limitations

Read this before relying on council output.

## What This Skill Does

- Runs multiple independent AI reviewers with different roles and (optionally) different models.
- Enforces an honesty charter, mandatory adversarial review, quality gates, and supervisor synthesis.
- Shows token/cost estimates before launching any model calls.
- Can save session transcripts for audit (opt-out available).

## What This Skill Does NOT Guarantee

1. **Honesty is prompt-enforced, not deterministic.** Models may still agree too readily, miss flaws, or hedge when they should reject. The charter reduces yes-manning; it does not eliminate it.

2. **Different models ≠ guaranteed different conclusions.** Model diversity helps but correlated errors are common on the same context.

3. **The chair is an LLM.** The chair may fail to enforce the checklist, paraphrase the charter, or miss agreeableness signals. v0.2 may add hooks; v0.1 relies on instructions.

4. **Council output is advice, not authority.** ADOPT is not approval to skip human review on production, security, legal, or financial decisions.

5. **Budget tier trades depth for cost.** Cheaper models may produce softer critique. Use `standard` or `premium` for high-stakes decisions.

6. **Context is only as good as what the chair includes.** The chair excludes sensitive files by blocklist but cannot prevent secrets pasted into chat.

## When to Trust Council Output

- Multiple members REJECT or REVISE with specific, evidenced flaws.
- DevilsAdvocate dissent is substantive, not performative.
- Supervisor flags agreeableness or lists a clear "Do not do" section.
- Red Team round was triggered and reinforced concerns.

## When to Be Skeptical

- Unanimous ADOPT on a large or risky proposal.
- Thin flaws ("might be complex", "could take time") without specifics.
- Verdict/reason mismatch (ADOPT with mostly negative summary).
- Budget tier on a security, architecture, or business-critical decision.

## Your Responsibility

You decide. The council exists to stress-test your thinking — not replace it.
