# Contributing to cursor-llm-council

Thanks for helping improve the council. This project is prompts and markdown — no runtime code, but changes affect how agents behave.

## Quick contributions

- Fix typos in docs
- Add examples to `skill/examples.md`
- Improve install script portability
- Report models that are unavailable on your account (with suggested fallbacks)

## Adding a council persona

1. Create `agents/council-<name>.md` with YAML frontmatter (`name`, `description`) and role-specific instructions.
2. Add the role to `skill/council-roster.md` with default model and fallbacks.
3. Add tier entries in `skill/config.example.yaml`.
4. Update `docs/architecture.md` if the workflow changes.
5. Add an example invocation if the persona needs a specific trigger.

## Changing model defaults

Open a PR with:

- Which model you're changing and why
- Fallback chain tested on your account
- Note if the model is premium-only (cost impact)

Do not hardcode models unavailable to most users without fallbacks.

## Changing personas (`agents/council-*.md`)

**Extra review required.** Persona bodies are pasted verbatim into subagent prompts, same as the honesty charter. A malicious or careless persona can instruct members to ignore the blocklist or read credential files.

PR must include:

- Full diff of persona prompt text
- Confirmation the persona does not instruct reading secrets or bypassing the charter
- Maintainer review before merge

## Changing the honesty charter

**Extra review required.** Changes to `skill/honesty-charter.md` affect every council session.

PR must include:

- Exact diff and rationale
- Before/after sample transcript or expected behavior change
- Maintainer acknowledgment that softer charter = weaker council

We will reject PRs that remove mandatory objections, banned phrases, or verdict requirements without strong justification.

## PR checklist

- [ ] `skill/SKILL.md` remains under 500 lines
- [ ] Linked files updated if SKILL.md references change
- [ ] `README.md` token table updated if cost model changes
- [ ] `CHANGELOG.md` entry added
- [ ] No secrets or real credentials in examples
- [ ] Install paths remain `~/.cursor/skills/llm-council` and `~/.cursor/agents/`
- [ ] Never install to `~/.cursor/skills-cursor/` (Cursor reserved)

## Code of conduct

Be direct and constructive. Match the council's tone: criticize ideas, not people.

## Development / testing

1. Clone repo
2. `./install.sh --force` or `.\install.ps1 -Force`
3. In Cursor: `/council <topic>` on a deliberately bad idea
4. Confirm pre-flight shows, DevilsAdvocate dissents, supervisor produces "Do not do"

## Questions

Open a GitHub issue with the `question` label.
