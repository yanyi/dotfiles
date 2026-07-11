---
name: docs-codify
description: "Refine technical documentation into concise, navigable pages with links from referenced symbols to their defining source files. Use when writing or cleaning up FAQs, integration guides, partner docs, or other technical docs, especially after updating documentation. Works across Go, TypeScript, Python, and other languages; do not use for code comments."
---

# docs-codify

Refine technical documentation to be succinct, code-linked, and optimized for both engineers (IDE navigation) and AI (context-efficient).

## Workflow

1. Read the target document and identify its audience, scope, and referenced
   code.
2. Find definition sites with `Grep`; do not guess paths or symbols from memory.
3. Add relative file links using the rules below, keeping the link text as the
   reader-facing symbol name.
4. Remove prose that restates implementation details while preserving reasons,
   constraints, and operational context.
5. Read a sample of linked files to verify that paths and symbols exist. Leave a
   reference unlinked rather than inventing a target when it cannot be resolved.
6. Edit documentation only. Do not change source code, credentials, or
   environment configuration as part of codification.

## Instructions

### 1. Identify code references

Find every mention of a symbol, function, type, config, or concept that maps to code:
- Functions, methods, classes, types, interfaces
- Config keys, constants, enums
- Module/package names when they clarify context

### 2. Resolve to file paths

Use `Grep` to locate the defining file for each symbol. Prefer the **definition site** (not call sites).

### 3. Apply linked symbol format

Replace bare symbol references with relative markdown links:

```md
[`symbol.name`](relative/path/to/file.ext)
```

Rules:
- Use **relative paths** from the doc file to the source file
- Use the **ecosystem's documentation convention** for symbol names in link text:
  - Go: `package.(*Type).Method` (GoDoc style)
  - TypeScript/JavaScript: `Module.className.method` or `functionName` (TSDoc style)
  - Python: `module.ClassName.method` (Sphinx style)
  - Rust: `crate::module::Type::method`
  - Other: use the idiomatic qualified name for the language
- Link to the **file**, not a line number (lines shift; files are stable)
- The symbol name in the link text is the search key for the reader

### 4. Trim prose

- Remove explanations that just restate what the code does - the link is the explanation
- Keep the **why** and **when**, drop the **how** (code shows how)
- One sentence per concept where possible
- Remove environment-specific tables (staging URLs, sandbox credentials, hardcoded IDs) - these go stale fast

### 5. Verify links

Run `Read` on a sample of linked files to confirm the symbol actually exists there.

## Examples

### Code trace (Go)

```md
[`config.Config.Endpoint`](../../../internal/config/config.go)
→ [`service.(*Handler).Handle`](../../../internal/service/handler.go)
→ [`client.Request.URL`](../../../internal/client/request.go)
```

### Code trace (TypeScript)

```md
[`renderAccount`](../../src/components/Account.tsx)
→ [`AccountService.create`](../../src/services/AccountService.ts)
→ [`ApiClient.post`](../../src/clients/api.ts)
```

### Q&A - before

```md
Legacy and validation errors returned by the parser are mapped to
`StatusInvalid`. See the status mapping logic in
`service.(*handler).parseAndUpdate`.
```

### Q&A - after

```md
Legacy and validation errors are mapped to `StatusInvalid`.
See [`Response.MapStatus`](../../../internal/api/response.go)
and [`service.(*handler).parseAndUpdate`](../../../internal/service/handler.go).
```

## What NOT to do

- Do not add line numbers to links (`file.go#L42`) - they go stale
- Do not create links for standard library or external package symbols
- Do not over-link **within a single paragraph** - if a symbol appears multiple times in the same paragraph, link it once. However, DO re-link symbols in separate sections/FAQ entries - each section should be self-contained so readers and AI agents can understand it without reading earlier sections
- Do not remove context that explains **why** something works a certain way
- Do not add environment-specific data (staging URLs, test credentials, sandbox IDs) - keep those in playbooks or env-specific docs, not in durable FAQs
