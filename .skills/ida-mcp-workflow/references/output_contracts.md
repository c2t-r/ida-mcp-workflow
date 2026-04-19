# Output Contracts

## `functions/*.md`

One durable note per important function.

- Name files after the best stable function identifier available, using a search-friendly ASCII filename.
- Start with the current function name as the title
- Include `namespace`, `mangled`, `demangled`, and `address` near the top
- List the strongest callers before the details section
- Summarize arguments, return value, side effects, and the reason the function matters
- Include pseudocode only when it materially clarifies the note
- Example: [function_note.md](./examples/function_note.md)

## `tasks/subjects.md`

Keep the topic index short and scan-friendly.

- one bullet per topic
- include purpose
- include state
- include the strongest current observation when useful
- Example: [subjects.md](./examples/subjects.md)

## `tasks/<slug>/task.md`

Capture the task contract.

- goal
- assumptions or prerequisites
- non-goals
- initial plan when the path is not obvious
- create this when the topic is opened, not after the analysis is done
- Example: [task.md](./examples/task/task.md)

## `tasks/<slug>/walkthrough.md`

Use a chronological log.

- timestamp or clear sequence marker
- what was inspected
- what was learned
- what the next step should be
- create this before deep analysis so the investigation has a durable log from the start
- Example: [walkthrough.md](./examples/task/walkthrough.md)

## `tasks/<slug>/quick.md`

Write the shortest defensible answer for the user.

- lead with the conclusion
- keep only the evidence needed to justify the answer
- add this once the main path is understood well enough to defend
- Example: [quick.md](./examples/task/quick.md)

## `tasks/<slug>/detail.md`

Write the fuller explanation.

- overall flow
- important entry points
- evidence behind the main claim
- unresolved gaps or residual uncertainty
- add this when the investigation is ready to stand on its own without live retelling
- Example: [detail.md](./examples/task/detail.md)

## Split documents

Add topic-specific files under `tasks/<slug>/` when the detail file becomes too dense.

- protocol header layout
- key derivation notes
- asset format breakdowns
- Example: [header.md](./examples/task/header.md)
