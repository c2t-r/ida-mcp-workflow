# AGENTS.md

Use `$ida-mcp-workflow` for repository setup and IDA research work in this repository, even when the user does not name
the skill explicitly. Use `$idapython` when the task needs concrete IDA Python API examples or helper scripts.

## Required MCP

- `ida-pro-mcp`
- If `ida-pro-mcp` is unavailable, report that clearly and stop instead of guessing.

## Repository Rules

- `README.md` is for human. For the agent workflow, durable output locations, and task scaffolding rules, follow `$ida-mcp-workflow`.
- For analysis-oriented requests, default to `$ida-mcp-workflow` without waiting for the user to mention it explicitly.
- Keep repository-wide instructions short here. Put step-by-step workflow details in `$ida-mcp-workflow`.
- Do not start deep IDA analysis before creating the task scaffold required by `$ida-mcp-workflow`.
- For a new analysis topic, create `tasks/<slug>/task.md` and `tasks/<slug>/walkthrough.md` first, then update `tasks/subjects.md`, and only then continue with substantive investigation.
- Treat the initial task scaffold as a required commit checkpoint unless the user explicitly asks not to commit or the current task is clearly a no-commit drafting pass.
- Do not invent alternate output locations.
- For PoC work, run `pnpm run fixpy` before finishing the work.
- When editing tracked Markdown files under the repo root, `functions/`, or `tasks/`, run `pnpm run lint` before finishing the work.
- Keep user-provided binaries, extracted source dumps, and helper artifacts under `resources/`.
- Put per-function notes under `functions/`.
- Put per-topic research artifacts under `tasks/<slug>/`.
- Keep `tasks/subjects.md` current as the task index.
