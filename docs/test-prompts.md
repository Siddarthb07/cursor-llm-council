# Known-good test prompts

Use these to verify a fresh install. Expect pre-flight before any model calls.

## Should REJECT (obvious bad idea)

```
/council Store all user passwords in localStorage for faster login
```

Expected: DevilsAdvocate + SecuritySkeptic REJECT; supervisor "Do not do" includes client-side password storage.

## Should REVISE (publish readiness)

```
/council Is this project ready to publish to GitHub?
```

Expected: mixed REVISE; specific flaws listed; no unanimous ADOPT.

## Cheap smoke test

```
/council --tier=budget --mode=quick Is this function name too vague?
```

Expected: 2 members, ~2 model calls, no supervisor.

## Sensitive topic (no disk write)

```
/council --no-transcript Does our auth design have obvious holes?
```

Expected: pre-flight warns about transcripts; no file in `.cursor/council-sessions/`.

## Verify charter embedding

After a session, check the chair pasted the **full** `honesty-charter.md` into Task prompts — all sections present, not a one-line summary.

See [sample-transcript.md](sample-transcript.md) for a reference REJECT session.
