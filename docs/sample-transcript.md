# Council Session: Store user passwords in localStorage

**Date:** 2026-07-07T15:30:00Z
**Tier:** standard | **Mode:** standard | **Supervisor:** on
**Quality gate:** pass
**Partial council:** no

## Config Snapshot

- Tier: standard
- Mode: standard
- Members: DevilsAdvocate, Architect, Pragmatist, SecuritySkeptic
- Supervisor: claude-4.6-opus-high-thinking
- Flags: none

## Context Packet

- **Topic:** Store all user passwords in browser localStorage for faster login UX
- **User goal:** Eliminate server round-trip on repeat visits; "remember me" without cookies
- **Constraints:** Web SPA, no backend session store budget
- **Relevant files:** None provided

---

## DevilsAdvocate — claude-opus-4-8-thinking-high

**Verdict:** REJECT
**Confidence:** high

### Summary

This stores the highest-value credential in the most exposed client-side store. Any XSS, malicious extension, or physical device access yields plaintext passwords. This is not a trade-off — it is negligent for any real application.

### Strengths

1. Repeat login is faster (`inference`) — eliminates one network hop on return visits.
2. Implementation is trivial (`fact`) — `localStorage.setItem` works everywhere.

### Flaws (min 2, mandatory)

1. **XSS = total credential compromise** (`fact`): Any script injection reads `localStorage`; httpOnly cookies exist specifically to prevent this.
2. **No revocation path** (`fact`): Stolen localStorage persists until user clears browser data; server cannot invalidate.
3. **Shared-device exposure** (`fact`): Family computer, library kiosk — password remains after "logout" unless explicitly cleared.

### Risks if we proceed anyway

Regulatory exposure (GDPR breach notification), credential stuffing cascade if DB later added, irreversible trust loss after first incident.

### Conditions that would change my verdict

Server-side session tokens in httpOnly secure cookies with refresh rotation; or WebAuthn/passkeys with no password retention client-side.

---

## Architect — gemini-3.1-pro

**Verdict:** REJECT
**Confidence:** high

### Summary

Architecturally conflates **authentication state** with **credential storage**. Sessions belong in short-lived tokens; passwords never belong in the browser.

### Strengths

1. Stateless server possible if only storing password hash server-side later (`inference`).
2. Works offline-first for demo prototypes (`inference`).

### Flaws

1. **Wrong trust boundary** (`fact`): Password is a long-term secret; localStorage is a public JavaScript-accessible API.
2. **Blocks secure evolution** (`inference`): Migrating to proper auth later requires password reset for all users.
3. **Multi-tab/session sync undefined** (`inference`): Logout in one tab does not clear others without custom sync.

### Risks if we proceed anyway

Technical debt that becomes migration project; team normalizes insecure patterns.

### Conditions that would change my verdict

Use opaque session ID in httpOnly cookie; password only transits over TLS during login, never stored client-side.

---

## Pragmatist — gpt-5.4-medium

**Verdict:** REJECT
**Confidence:** high

### Summary

Saves perhaps one API call per return visit. Cost of breach response, support, and rebuild dwarfs any UX gain. Simpler secure alternative exists.

### Strengths

1. Zero session infrastructure for MVP demo (`fact`).
2. Faster repeat login (`inference`).

### Flaws

1. **Effort mismatch** (`inference`): Saving server session store "budget" costs more in incident response than Redis would cost for years.
2. **False MVP** (`inference`): Demo auth that must be ripped out teaches wrong patterns to team.
3. **Support burden** (`inference`): "I logged out but my password is still there" tickets.

### Risks if we proceed anyway

Shipping demo to production by accident — common pattern.

### Conditions that would change my verdict

httpOnly session cookie + 15-minute setup with any standard auth library.

---

## SecuritySkeptic — claude-sonnet-5-thinking-high

**Verdict:** REJECT
**Confidence:** high

### Summary

Violates OWASP guidance on credential storage. Attack surface includes XSS, extensions, forensic disk access, and backup sync of browser profiles.

### Strengths

None for production. Acceptable only for throwaway local-only toy with fake data (`speculation`).

### Flaws

1. **Plaintext credential at rest in browser** (`fact`) — CWE-522.
2. **Accessible to any same-origin script** (`fact`) — no integrity protection.
3. **Synced across devices** (`inference`) — iCloud/Chrome sync spreads compromise.

### Risks if we proceed anyway

Mass credential theft from single XSS bug; legal liability if real user data.

### Conditions that would change my verdict

WebAuthn, or session tokens with httpOnly + Secure + SameSite.

---

## Supervisor Verdict

### Scoring Matrix

| Dimension       | Score (1-10) | Key driver |
|-----------------|--------------|------------|
| Feasibility     | 9            | Trivial to build — that's the problem |
| Security        | 1            | Fundamental credential exposure |
| Value           | 2            | Minor UX gain |
| Maintainability | 3            | Migration pain later |
| Cost            | 2            | Breach cost >> infra savings |
| **Weighted**    | **2.8**      | |

**Idea rating:** REJECT

**Recommended path:** Use httpOnly secure session cookies or WebAuthn. Password transits once over TLS at login; never persist client-side.

**Do not do:**

- Store passwords in localStorage, sessionStorage, or IndexedDB
- Store passwords in JWT payloads client-side
- "Encrypt" password in localStorage with client-side key (key is also in JS)

**Dissent:** None — unanimous REJECT.

**Agreeableness audit:** pass (strong dissent, substantive flaws)

**Confidence:** high

---

*This sample demonstrates expected council behavior on a clearly bad idea. Honesty is prompt-enforced; real sessions may vary.*
