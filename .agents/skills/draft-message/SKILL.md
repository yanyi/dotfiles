---
name: draft-message
description: "Draft concise short-form messages to people or teams on the user's behalf, including PR reviews, reviewer or bot replies, Slack, GitHub, and Jira. Use when asked to draft, word, tighten, shorten, soften, or acknowledge a comment or reply. Do not use for standalone documents such as PR descriptions, ticket bodies, Confluence pages, or READMEs."
---

# Draft a Message

One source of truth for how to address a person or team in short-form, on the
user's behalf. Conversational messages only: comments, replies, review notes,
Slack messages, issue comments. Document-shaped artifacts (PR descriptions, ticket
bodies, Confluence, READMEs) are out of scope - they read as standalone
artifacts and follow the "present current state, not change history" rule, not
this one.

This skill drafts text only. Do not post or send the message, or modify a remote
system, unless the user explicitly asks and the available tools support it.

The bar: the reader grasps the point in one pass and knows exactly what, if
anything, they must do. Length is the cost, not the signal. Effort spent
drafting or reviewing is never a reason to write more.

## Workflow

1. Identify the surface, reader, and action required. Use the surrounding thread,
   review, or diff as context instead of repeating it.
2. Draft the shortest message that leads with the answer or ask.
3. Preserve the user's facts and commitments. Ask one focused question when a
   necessary fact is missing; do not invent context or third-party behavior.
4. Apply the formatting and process-narration sweeps below.
5. Return the postable message unless the user asks for explanation or options.

## Core rules

- **Lead with the ask or the answer.** First sentence carries the point: the
  request, the conclusion, the one fact that matters. No framing sentence, no
  recap of what the reader already said or can see. One concern per paragraph.
- **Shortest version that conveys it - usually 1 to 3 sentences.** If the draft
  is a paragraph of context ending in a question, the postable version is the
  question plus the single fact that makes it concrete.
- **Impersonal voice for statements.** State what is true or what was found, not
  who found it ("the rename sits in the shared helper", not "I noticed the
  rename..."). "Could we..." / "Can we..." is the right register only in the
  ask itself. This targets in-the-moment individual narration ("I noticed",
  "after checking"); a decision the team made or owns may use "we" ("we
  suppressed the consumer banner", "we kept the error in-component") when that
  is the natural subject.
- **Cut preamble and affirmations.** Drop "Great question", "Good catch", "Nice
  work", "Sure!", "Happy to help", "Just to confirm", and any sentence that
  restates the request before answering it.
- **No process narration.** Never describe what you did to produce the message
  ("verified the callers", "traced the blast radius", "after checking") or
  assert that a clean thing is clean. That belongs in working notes shown to the
  user, never in the message to the reader.
- **Right-size the verb.** "Could we..." / "small nit:" for minor asks; a direct
  plain statement for a real blocker. Never inflate a nit into a demand, never
  soften a blocker into a maybe.
- **Plain words, no insider shorthand.** Avoid terms the reader cannot resolve
  without context ("in prose", "the ledger"); say what you mean. Simple words
  over clever phrasing.
- **Link and cite sparingly.** Reference a PR, commit, issue, or doc once, where
  it adds value. Do not cross-link both directions when one side already links
  the other; do not re-cite the same evidence twice.
- **Verify third-party claims before asserting them.** Before stating how a
  library, tool, or API behaves, confirm against the installed version or
  official docs and cite the source inline. Never assert from memory.

## Hard formatting rules

- **No em dashes or en dashes (— –).** Use commas, colons, parentheses, a spaced
  hyphen, or separate sentences.
- **Backtick code-ish tokens.** Wrap file paths, `file:line`, identifiers,
  function/method names, field accessors, CLI flags, env vars, config keys, HTTP
  routes, JSON/log fields, and provider names that name a code symbol.
  The easy misses read as plain English: a lowercase provider name (`providerx`)
  or a `snake_case` field looks like prose but is a code token, backtick it.
  Commit SHAs: bare hashes only on GitHub (PR and issue comments), where GitHub
  auto-links them; on other surfaces (Slack, Jira) there is no auto-link, so
  backtick a SHA like any other code token.
- **Plain prose for short messages.** Avoid bold headers, section labels,
  numbered lists, and decorative emoji in a one- or two-point message. Use a
  minimal approval token such as `LGTM` or `👍` when that is the surface
  convention.

## Acknowledge, don't recap

When replying to someone's feedback, question, or review finding you have
addressed: point to the source of truth (a bare commit SHA, a link, a file or
symbol) and stop. The reader can read the diff; do not narrate it back to them.

Add a line only when the reader must react to something: a deviation from what
they suggested, which option you chose when they offered several, or a tradeoff
you made. `Done in 1a2b3c4.` is a complete reply when the artifact speaks for
itself.

```
Bad   @reviewer applied in 1a2b3c4. The parser now handles the invalid input,
      returns the documented error, and preserves the original request for
      diagnostics.

Good  @reviewer applied in 1a2b3c4.
```

The reader opens the source of truth if they want the detail. The recap costs
their attention and adds nothing the artifact does not already say.

## Capturing findings or decision context

Some comments record facts for reuse (a root cause, a decision lineage, "how X
actually works"), not a reply. Here recap is the point, so "acknowledge, don't
recap" does not apply; the discipline is distillation instead.

- **One line per fact or decision.** A chronological or topic lineage (one
  ticket or decision per line) beats prose paragraphs.
- **Carry the conclusion, not the evidence trail.** Drop commit SHAs, PR
  numbers, file paths, and quotes unless the reader must act on them; the linked
  ticket or code holds the detail. Sourcing grounds your own confidence while
  drafting, it is not freight for the reader.
- **A document is not a comment.** Section headers and five-plus parts mean it
  belongs in a doc, or distilled to the load-bearing list.
- **Match the thread when appending.** Continue the existing comment's intro and
  shape (e.g. "More findings:") rather than imposing a new structure.

## Replying to reviewers and bots

- **Rebut a wrong finding with the one disproof, then stop.** State the fact that
  disproves it and end. Do not add where the mistaken reference came from or pad
  with provenance; it reads as defensive. Two sentences is plenty.
- **Concede quickly when the other person is right.** Acknowledge in one line and
  move on; do not relitigate or re-frame. Visible concession is what keeps people
  engaging honestly.
- **Tag whoever must act.** When a reply needs someone to re-check or
  re-evaluate, address them explicitly (`@reviewer`, `@name`) so the thread
  does not stall on someone who was not pinged.

## Surface notes

- **Slack.** Use the full permalink from Slack's "Copy link" (it carries
  `?thread_ts=...&cid=...`); never hand-build or shorten to the bare
  `/archives/<channel>/p<ts>` form, which deep-links unreliably in the desktop
  app. Channel-specific voice (lowercase, emoji tokens like `:plusone:`) belongs
  to a dedicated Slack skill when one is installed; this skill governs the
  cross-surface principles above.
- **GitHub / PR reviews.** Severity tags, confidence labels, inline-vs-body
  anchoring, suggestion blocks, and review tracking are separate concerns; this
  skill governs the wording inside each comment.
- **Approvals.** Default to a minimal token (`LGTM`, `👍`). Escalate to a clause
  only for a real caveat (`LGTM. Nit: <one thing>`). Never recap what was
  reviewed; the reviewer's name already says "I read this."

## Before you return the draft

Re-read the draft once as the reader will read it, with the thread or diff in
front of them, and run two sweeps:

1. **Process-narration sweep.** Delete any sentence describing what you did or
   asserting a clean thing is fine. If removing it empties the message, the
   correct message is the one-line acknowledgement (plus a SHA or link).
2. **Backtick sweep.** Scan for bare code tokens (the lowercase names and
   `snake_case` fields slip through) and backtick them; check for em dashes.

Then cut anything that is not the point, the evidence, or the ask, and anything
that restates context the reader already has.
