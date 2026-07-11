# Personal Engineering Guidance

These are default preferences. Follow project-specific instructions when they are more specific, and ask when instructions conflict.

## Core Principles

- Parse, don't validate: parse external input into trusted domain types at system boundaries.
- Always use TDD: red, green, refactor. Test behavior and invariants rather than implementation details.
- Apply SOLID principles pragmatically; avoid abstractions without a concrete need.
- Make invalid states unrepresentable wherever practical.
- Keep boundaries explicit and domain logic independent of infrastructure.
- Prefer simple, clear, and boring code over cleverness.
- Follow KISS and YAGNI; do not build speculative functionality.
- Keep modules cohesive and dependencies loosely coupled.
- Make side effects and mutation explicit and narrow.
- Fail fast and visibly; never silently swallow errors.
- Secure by default: use least privilege and treat external data as untrusted.
- Measure before optimizing.

## Working Practices

- Inspect the existing code and project instructions before making changes.
- Make changes small, focused, and reviewable.
- Add a regression test for every bug fix.
- Run the narrowest relevant checks first, then the broader test suite when practical.
- Do not rely on memory for repository-specific behavior, tool syntax, APIs, or version-sensitive facts. Verify against repository sources first.
- For third-party tools, APIs, and dependencies, consult the latest authoritative, version-matched documentation or source for the version in use. Do not assume that unversioned or latest-version documentation applies.
- If authoritative, version-matched information is unavailable, state the uncertainty rather than guessing.
- Do not change unrelated code or revert changes made by someone else.
- Prefer existing project tools and conventions over introducing new dependencies or patterns.
- Document decisions, invariants, and non-obvious tradeoffs close to the code.
- Report what changed, what was verified, and any remaining risks.
