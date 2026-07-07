# Failure Recovery

How the chair handles subagent failures, model unavailability, and partial councils.

## Subagent Task Failure

1. **Retry once** with the same prompt and model.
2. If retry fails, try the **first fallback model** from config or `council-roster.md`.
3. If fallback fails, **proceed with partial council** — note the missing member in transcript.
4. **Never fabricate** the missing member's opinion.

## Model Unavailable

Symptoms: Task error mentioning unknown model, access denied, or model not on account.

1. Try fallback chain in order (see `council.config.yaml` or `council-roster.md`).
2. If all fallbacks fail for a role, skip that member and document in transcript.
3. Inform user which member was skipped and why.

## Partial Council Rules

- Supervisor still runs if at least **2 member reports** exist (or 1 in `quick` mode).
- Supervisor must note: `Partial council: missing <RoleName>`.
- Do not lower verdict confidence silently — set supervisor confidence to `medium` or `low` when partial.

## Red Team Failure

If Red Team Task fails after retry + fallback:

- In `deep` mode: note failure prominently; supervisor must apply extra skepticism manually.
- In gate-triggered mode: show warning that Red Team could not run; user may re-run council.

## Supervisor Failure

1. Retry once.
2. Try fallback supervisor model.
3. If still failing: present raw member reports with verdict count table (see output-templates.md).
4. Tell user supervisor synthesis failed.

## Timeout / Hung Tasks

If a Task hangs beyond reasonable wait:

1. Do not launch duplicate Tasks for the same role.
2. Proceed with completed members after one retry on the hung role.
3. Note timeout in transcript.

## Config Load Failure

If `council.config.yaml` is missing or invalid:

1. Fall back to `council-roster.md` defaults.
2. Note in transcript: `Config: defaults (file missing or invalid)`.
3. v0.2: if `config.schema.json` validation fails, warn user and use defaults.

## Retry Billing Note

Each retry is an additional model invocation. Mention in pre-flight if a prior session had failures (optional).
